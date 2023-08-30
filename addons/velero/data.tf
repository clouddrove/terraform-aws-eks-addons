data "aws_region" "current" {}
data "aws_eks_cluster" "eks_cluster" {
  name = var.eks_cluster_name
}