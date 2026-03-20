output "service_account" {
  description = "The Kubernetes service account name created for the Helm deployment."
  value       = "${local.name}-sa"
}

output "iam_policy" {
  description = "The IAM policy name generated using the module name and EKS cluster name."
  value       = "${local.name}-${var.eks_cluster_name}"
}

output "namespace" {
  description = "The Kubernetes namespace where the Helm release is deployed."
  value       = local.default_helm_config.namespace
}

output "chart_version" {
  description = "The Helm chart version that is deployed."
  value       = local.default_helm_config.version
}

output "repository" {
  description = "The Helm chart repository URL used for deployment."
  value       = local.default_helm_config.repository
}