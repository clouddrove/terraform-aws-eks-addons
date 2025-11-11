data "aws_eks_cluster" "eks_cluster" {
  # this makes downstream resources wait for data plane to be ready
  name = var.eks_cluster_name
}
data "aws_region" "current" {}

resource "terraform_data" "region" {
  input = data.aws_region.current.name

  lifecycle {
    ignore_changes = all
  }
}

resource "terraform_data" "vpc_id" {
  input = data.aws_eks_cluster.eks_cluster.vpc_config[0].vpc_id

  lifecycle {
    ignore_changes = all
  }
}