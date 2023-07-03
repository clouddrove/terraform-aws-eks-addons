output "oidc_arn" {
    value = "${data.aws_eks_cluster.eks_cluster.arn}"
}

output "oidc_issuer" {
    value = "${data.aws_eks_cluster.eks_cluster.identity[0].oidc[0].issuer}"
}