
locals {

  name   = "tf-helm-eks-addons"
  region = "us-east-1"

  vpc_cidr = "10.0.0.0/16"
  azs      = slice(data.aws_availability_zones.available.names, 0, 3)

  tags = {
    Example    = local.name
    GithubRepo = "terraform-helm-eks-addons"
    GithubOrg  = "clouddrove"
  }
  cluster_version = "1.26"
}