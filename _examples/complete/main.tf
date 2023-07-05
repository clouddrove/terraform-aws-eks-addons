# ------------------------------------------------------------------------------
# Resources
# ------------------------------------------------------------------------------

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.0.0"

  name = "${local.name}-vpc"
  cidr = local.vpc_cidr

  azs              = local.azs
  private_subnets  = [for k, v in local.azs : cidrsubnet(local.vpc_cidr, 8, k)]
  public_subnets   = [for k, v in local.azs : cidrsubnet(local.vpc_cidr, 8, k + 4)]
  database_subnets = [for k, v in local.azs : cidrsubnet(local.vpc_cidr, 8, k + 8)]

  enable_nat_gateway           = true
  single_nat_gateway           = true
  create_database_subnet_group = false

  public_subnet_tags = {
    "kubernetes.io/role/elb" = "1"
  }

  private_subnet_tags = {
    "kubernetes.io/role/internal-elb" = 1
  }

  tags = local.tags
}

################################################################################
# VPC Supporting Resources
################################################################################

data "aws_security_group" "default" {
  name   = "default"
  vpc_id = module.vpc.vpc_id
}

###############################################################################
# AWS EKS
###############################################################################
data "aws_eks_cluster" "eks_cluster" {
  # this makes downstream resources wait for data plane to be ready
  name = module.eks.cluster_name
  depends_on = [ 
    module.eks.cluster_id
   ]
}

module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "19.15.3"

  cluster_name                   = "${local.name}-eks-cluster"
  cluster_version                = local.cluster_version
  cluster_endpoint_public_access = true

  cluster_ip_family = "ipv4"

  # Set this to true if AmazonEKS_CNI_IPv6_Policy policy is not available
  create_cni_ipv6_iam_policy = false

  cluster_addons = {
    vpc-cni = {
      most_recent    = true
      before_compute = true
      configuration_values = jsonencode({
        env = {
          ENABLE_PREFIX_DELEGATION = "true"
          WARM_PREFIX_TARGET       = "1"
        }
      })
    }
  }

  vpc_id     = module.vpc.vpc_id
  subnet_ids = module.vpc.private_subnets

  # manage_aws_auth_configmap = true
  # create_aws_auth_configmap = true

  eks_managed_node_group_defaults = {
    ami_type                   = "AL2_x86_64"
    instance_types             = ["t3.medium"]
    disk_size                  = 20
    iam_role_attach_cni_policy = true
    use_custom_launch_template = false
    iam_role_additional_policies = {
      policy_arn = aws_iam_policy.node_additional.arn
      AWSLoadBalancerControllerIAMPolicy = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:policy/AWSLoadBalancerControllerIAMPolicy"
    }
    tags = {
      "kubernetes.io/cluster/${module.eks.cluster_name}" = "shared"
    }
  }

  eks_managed_node_groups = {
    critical = {
      name            = "critical"
      instance_types  = ["t3.medium"]
      use_name_prefix = false
      capacity_type   = "ON_DEMAND"
      min_size        = 1
      max_size        = 2
      desired_size    = 1

    }

    application = {
      name            = "application"
      instance_types  = ["t3.medium"]
      use_name_prefix = false
      capacity_type   = "SPOT"
      min_size        = 0
      max_size        = 1
      desired_size    = 0
    }

  }
  tags = local.tags
}

################################################################################
# EKS Supporting Resources
################################################################################
data "aws_caller_identity" "current" {}
data "aws_availability_zones" "available" {}

module "vpc_cni_irsa" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-role-for-service-accounts-eks"
  version = "~> 5.0"

  role_name_prefix      = "VPC-CNI-IRSA"
  attach_vpc_cni_policy = true
  vpc_cni_enable_ipv6   = true

  oidc_providers = {
    main = {
      provider_arn               = module.eks.oidc_provider_arn
      namespace_service_accounts = ["kube-system:aws-node"]
    }
  }

  tags = local.tags
}

resource "aws_iam_policy" "node_additional" {
  name        = "${local.name}-additional"
  description = "Example usage of node additional policy"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "ec2:Describe*",
          "autoscaling:Describe*",
          "eks:Describe*",
          "autoscaling:SetDesiredCapacity",
          "autoscaling:TerminateInstanceInAutoScalingGroup",
          "elasticloadbalancing:DescribeLoadBalancers"
        ]
        Effect   = "Allow"
        Resource = "*"
      },
    ]
  })

  tags = local.tags
}

data "aws_ami" "eks_default" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amazon-eks-node-${local.cluster_version}-v*"]
  }
}

data "aws_ami" "eks_default_arm" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amazon-eks-arm64-node-${local.cluster_version}-v*"]
  }
}

resource "local_file" "kubeconfig" {
  depends_on = [ 
    module.eks.cluster_id
  ]
  content = <<EOF
apiVersion: v1
clusters:
- cluster:
    certificate-authority-data: ${module.eks.cluster_certificate_authority_data}
    server: ${module.eks.cluster_endpoint}
  name: ${module.eks.cluster_arn}
  
contexts:
- context:
    cluster: ${module.eks.cluster_arn}
    user: ${module.eks.cluster_arn}
  name: ${module.eks.cluster_arn}
    
current-context: ${module.eks.cluster_arn}
kind: Config
preferences: {}
users:
- name: ${module.eks.cluster_arn}
  user:
    exec:
      apiVersion: client.authentication.k8s.io/v1beta1
      args:
      - --region
      - ${local.region}
      - eks
      - get-token
      - --cluster-name
      - ${module.eks.cluster_name}
      command: aws
EOF
   filename     = "${path.cwd}/config/kubeconfig"
}

resource "null_resource" "kubectl" {
  depends_on = [ module.eks ]
  provisioner "local-exec" {
    command = "export KUBE_CONFIG_PATH=${path.cwd}/config/kubeconfig && aws eks update-kubeconfig --name ${module.eks.cluster_name} --region ${local.region}"
  }
}

# resource "null_resource" "kubectl" {
#   depends_on = [ module.eks ]
#   provisioner "local-exec" {
#     command = "aws sts assume-role --role-arn arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/terraform-helm-eks-addon} --role-session-name AWSCLI-Session"
#   }
# }

module "addons" {
  source = "../../addons"
  #version = "0.0.1"

  depends_on = [ null_resource.kubectl ]
  # depends_on = [ module.eks.cluster_id ]

  eks_cluster_id   = module.eks.cluster_id
  eks_cluster_name = module.eks.cluster_name

  enable_metrics_server = true
  enable_cluster_autoscaler = true
  enable_aws_load_balancer_controller = true

}