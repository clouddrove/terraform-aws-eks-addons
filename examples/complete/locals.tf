locals {
  region          = "us-east-1"
  name            = "helm-addons"
  environment     = "test"
  cluster_version = "1.32"
  vpc_cidr        = "10.0.0.0/16"
  azs             = slice(data.aws_availability_zones.available.names, 0, 3)
  tags = {
    Name        = local.name
    Environment = local.environment
    GithubRepo  = "terraform-helm-eks-addons"
    GithubOrg   = "clouddrove"
  }
}