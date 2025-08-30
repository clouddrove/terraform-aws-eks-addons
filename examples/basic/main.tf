################################################################################
## ADDON MODULE CALL
################################################################################
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

##-----------------------------------------------------------------------------
## NETWORKING & EKS MODULE CALL
##-----------------------------------------------------------------------------
module "vpc" {
  source  = "clouddrove/vpc/aws"
  version = "2.0.0"

  name        = "${local.name}-vpc"
  environment = local.environment
  cidr_block  = local.vpc_cidr
}

module "subnets" {
  source  = "clouddrove/subnet/aws"
  version = "2.0.0"

  name                = "${local.name}-subnet"
  environment         = local.environment
  nat_gateway_enabled = true
  single_nat_gateway  = true
  availability_zones  = ["${local.region}a", "${local.region}b", "${local.region}c"]
  vpc_id              = module.vpc.vpc_id
  type                = "public-private"
  igw_id              = module.vpc.igw_id
  cidr_block          = module.vpc.vpc_cidr_block
  ipv6_cidr_block     = module.vpc.ipv6_cidr_block
  enable_ipv6         = false

  public_inbound_acl_rules = [
    {
      rule_number = 100
      rule_action = "allow"
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_block  = "0.0.0.0/0"
    },
    {
      rule_number     = 101
      rule_action     = "allow"
      from_port       = 0
      to_port         = 0
      protocol        = "-1"
      ipv6_cidr_block = "::/0"
    }
  ]
  public_outbound_acl_rules = [
    {
      rule_number = 100
      rule_action = "allow"
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_block  = "0.0.0.0/0"
    },
    {
      rule_number     = 101
      rule_action     = "allow"
      from_port       = 0
      to_port         = 0
      protocol        = "-1"
      ipv6_cidr_block = "::/0"
    }
  ]
  private_inbound_acl_rules = [
    {
      rule_number = 100
      rule_action = "allow"
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_block  = "0.0.0.0/0"
    },
    {
      rule_number     = 101
      rule_action     = "allow"
      from_port       = 0
      to_port         = 0
      protocol        = "-1"
      ipv6_cidr_block = "::/0"
    }
  ]
  private_outbound_acl_rules = [
    {
      rule_number = 100
      rule_action = "allow"
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_block  = "0.0.0.0/0"
    },
    {
      rule_number     = 101
      rule_action     = "allow"
      from_port       = 0
      to_port         = 0
      protocol        = "-1"
      ipv6_cidr_block = "::/0"
    }
  ]
  extra_public_tags = {
    "kubernetes.io/cluster/${module.eks.cluster_name}" = "owned"
    "kubernetes.io/role/elb"                           = "1"
  }
  extra_private_tags = {
    "kubernetes.io/cluster/${module.eks.cluster_name}" = "owned"
    "kubernetes.io/role/internal-elb"                  = "1"
  }
}

module "http_https" {
  source  = "clouddrove/security-group/aws"
  version = "2.0.0"

  name        = "${local.name}-http-https"
  environment = local.environment
  vpc_id      = module.vpc.vpc_id
  new_sg_ingress_rules_with_cidr_blocks = [{
    rule_count  = 1
    from_port   = 80
    protocol    = "tcp"
    to_port     = 80
    cidr_blocks = [local.vpc_cidr]
    description = "Allow http traffic."
    },
    {
      rule_count  = 2
      from_port   = 443
      protocol    = "tcp"
      to_port     = 443
      cidr_blocks = [local.vpc_cidr]
      description = "Allow https traffic."
  }]
  new_sg_egress_rules_with_cidr_blocks = [{
    rule_count       = 1
    from_port        = 0
    protocol         = "-1"
    to_port          = 0
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
    description      = "Allow all traffic."
  }]
}

module "eks" {
  source  = "clouddrove/eks/aws"
  version = "1.4.5"
  enabled = true

  name        = local.name
  environment = local.environment

  # EKS
  kubernetes_version     = local.cluster_version
  endpoint_public_access = true

  vpc_id                            = module.vpc.vpc_id
  subnet_ids                        = module.subnets.private_subnet_id
  eks_additional_security_group_ids = [module.http_https.security_group_id]
  allowed_cidr_blocks               = [local.vpc_cidr]

  # AWS Managed Node Group
  # Default Values for all Node Groups
  managed_node_group_defaults = {
    subnet_ids = module.subnets.private_subnet_id
    tags = {
      "kubernetes.io/cluster/${module.eks.cluster_name}" = "owned"
      "k8s.io/cluster/${module.eks.cluster_name}"        = "owned"
    }
    block_device_mappings = {
      xvda = {
        device_name = "/dev/xvda"
        ebs = {
          volume_size = 50
          volume_type = "gp3"
          iops        = 3000
          throughput  = 150
        }
      }
    }
  }
  managed_node_group = {
    critical = {
      name                 = "critical"
      capacity_type        = "ON_DEMAND"
      min_size             = 1
      max_size             = 2
      desired_size         = 1
      force_update_version = true
      instance_types       = ["t3.medium"]
    }
  }
  apply_config_map_aws_auth = true
  map_additional_iam_users = [
    {
      userarn  = "arn:aws:iam::123456789012:user/hello@clouddrove.com"
      username = "hello@clouddrove.com"
      groups   = ["system:masters"]
    }
  ]
}
