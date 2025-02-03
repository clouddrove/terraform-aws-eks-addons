# ------------------------------------------------------------------------------
# Resources
# ------------------------------------------------------------------------------

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.18.1"

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
  version = "20.33.1"

  cluster_name                   = "${local.name}-cluster"
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

  eks_managed_node_group_defaults = {
    ami_type                   = "AL2_x86_64"
    instance_types             = ["t3.medium"]
    disk_size                  = 20
    iam_role_attach_cni_policy = true
    use_custom_launch_template = false
    iam_role_additional_policies = {
      policy_arn = aws_iam_policy.node_additional.arn
    }
    tags = {
      "kubernetes.io/cluster/${module.eks.cluster_name}" = "shared"
      "karpenter.sh/discovery"                           = module.eks.cluster_name
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
          "ec2:Describe*"
        ]
        Effect   = "Allow"
        Resource = "*"
      },
    ]
  })

  tags = local.tags
}

module "addons" {
  source = "../../"

  depends_on       = [module.eks]
  eks_cluster_name = module.eks.cluster_name

  # -- Enable Addons
  metrics_server               = true
  cluster_autoscaler           = true
  aws_load_balancer_controller = true
  aws_node_termination_handler = true
  aws_efs_csi_driver           = true
  aws_ebs_csi_driver           = true
  kube_state_metrics           = true
  karpenter                    = false # -- Set to `false` or comment line to Uninstall Karpenter if installed using terraform.
  calico_tigera                = true
  new_relic                    = true
  kubeclarity                  = true
  ingress_nginx                = true
  fluent_bit                   = true
  keda                         = true
  certification_manager        = true
  reloader                     = true
  external_dns                 = true
  redis                        = true
  actions_runner_controller    = true

  # -- Addons with mandatory variable
  istio_ingress    = true
  istio_manifests  = var.istio_manifests
  kiali_server     = true
  kiali_manifests  = var.kiali_manifests
  external_secrets = true
  velero           = true
  velero_extra_configs = {
    bucket_name = "velero-addons"
  }

}