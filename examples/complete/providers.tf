# ------------------------------------------------------------------------------
# Providers
# ------------------------------------------------------------------------------

provider "aws" {
  region = local.region
}

provider "kubernetes" {
  host                   = module.eks.cluster_endpoint
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.eks_cluster.certificate_authority[0].data)
  exec {
    api_version = "client.authentication.k8s.io/v1beta1"
    args        = ["eks", "get-token", "--cluster-name", data.aws_eks_cluster.eks_cluster.name]
    command     = "aws"
  }
}

provider "helm" {
  kubernetes {
    host                   = module.eks.cluster_endpoint
    cluster_ca_certificate = base64decode(module.eks.cluster_certificate_authority_data)
    exec {
      api_version = "client.authentication.k8s.io/v1beta1"
      args        = ["eks", "get-token", "--cluster-name", data.aws_eks_cluster.eks_cluster.name]
      command     = "aws"
    }
  }
}

provider "kubectl" {
  host                   = module.eks.cluster_endpoint
  cluster_ca_certificate = base64decode(module.eks.cluster_certificate_authority_data)
  token                  = data.aws_eks_cluster_auth.eks_cluster.token
  load_config_file       = false
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
data "aws_availability_zones" "available" {}
