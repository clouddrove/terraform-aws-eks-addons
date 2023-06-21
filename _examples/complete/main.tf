# ------------------------------------------------------------------------------
# Resources
# ------------------------------------------------------------------------------
module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "4.0.1"

  name = "${local.name}-vpc"
  cidr = local.vpc_cidr

  azs              = local.azs
  private_subnets  = [for k, v in local.azs : cidrsubnet(local.vpc_cidr, 8, k * 8 + 1)]
  public_subnets   = [for k, v in local.azs_public : cidrsubnet(local.vpc_cidr, 8, k * 8 + 2)]
  database_subnets = [for k, v in local.azs_database : cidrsubnet(local.vpc_cidr, 8, k * 8 + 3)]

  enable_nat_gateway           = true
  single_nat_gateway           = true
  create_database_subnet_group = false

  public_subnet_tags = {
    "kubernetes.io/cluster/${local.name}-eks-cluster" = "shared"
    "kubernetes.io/role/elb"                          = "1"
  }

  private_subnet_tags = {
    "kubernetes.io/cluster/${local.name}-eks-cluster" = "shared"
    "kubernetes.io/role/internal-elb"                 = 1
  }

  tags = local.tags

}

###############################################################################
# AWS EKS
###############################################################################

module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "19.13.1"

  cluster_name                    = "${local.name}-eks-cluster"
  cluster_version                 = "1.26"
  cluster_endpoint_public_access  = var.cluster_endpoint_public_access
  cluster_endpoint_private_access = var.cluster_endpoint_private_access
  iam_role_use_name_prefix        = var.iam_role_use_name_prefix

  # EKS Addons
  cluster_addons = {
    coredns    = {}
    kube-proxy = {}
    vpc-cni    = {}
  }

  vpc_id     = module.vpc.vpc_id
  subnet_ids = module.vpc.private_subnets

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
      min_size        = 1
      max_size        = 2
      desired_size    = 1
    }
  }
  tags = local.tags
}

module "addons" {
  source = "../../"
  #version = "0.0.1"
  name                 = local.name
  environment          = local.environment
  eks_cluster_name     = module.eks.cluster_name
  vpc_id               = module.vpc.vpc_id
  kms_key_arn          = ""
  worker_iam_role_name = module.eks.worker_iam_role_name
  kms_policy_arn       = module.eks.kms_policy_arn # eks module will create kms_policy_arn
  # Addons
  metrics_server_enabled = false
}
