# ------------------------------------------------------------------------------
# Providers
# ------------------------------------------------------------------------------

provider "aws" {
  region = local.region
}

provider "kubernetes" {
  host                   = module.eks.cluster_endpoint
  cluster_ca_certificate = base64decode(module.eks.cluster_certificate_authority_data)
  token                  = join("", data.aws_eks_cluster_auth.eks_cluster.*.token)
}

provider "helm" {
  kubernetes {
    host                   = module.eks.cluster_endpoint
    cluster_ca_certificate = base64decode(module.eks.cluster_certificate_authority_data)
    token                  = join("", data.aws_eks_cluster_auth.eks_cluster.*.token)
  }
}

provider "kubectl" {
  host                   = module.eks.cluster_endpoint
  cluster_ca_certificate = base64decode(module.eks.cluster_certificate_authority_data)
  token                  = join("", data.aws_eks_cluster_auth.eks_cluster.*.token)
}

# ------------------------------------------------------------------------------
# Data
# ------------------------------------------------------------------------------

data "aws_eks_cluster_auth" "eks_cluster" {
  name = data.aws_eks_cluster.eks_cluster.id
}
data "aws_eks_cluster" "eks_cluster" {
  name       = module.eks.cluster_name
  depends_on = [module.eks.cluster_id]
}
data "aws_caller_identity" "current" {}
data "aws_availability_zones" "available" {}