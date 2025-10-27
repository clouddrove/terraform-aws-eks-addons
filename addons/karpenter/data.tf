data "aws_eks_cluster" "eks_cluster" {
  # this makes downstream resources wait for data plane to be ready
  name = var.eks_cluster_name
}

resource "terraform_data" "endpoint" {
  input = data.aws_eks_cluster.eks_cluster.endpoint

  lifecycle {
    ignore_changes = all
  }
}