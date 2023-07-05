output "oidc_arn" {
  value = data.aws_eks_cluster.eks_cluster.arn
}

output "oidc_issuer" {
  value = data.aws_eks_cluster.eks_cluster.identity[0].oidc[0].issuer
}

output "policy" {
  value = data.aws_iam_policy_document.aws_load_balancer_controller_assume.json
}

output "test" {
  value = "Test Value"
}