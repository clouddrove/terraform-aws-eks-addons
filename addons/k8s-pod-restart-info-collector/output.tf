output "service_account" {
  description = "The Kubernetes service account name created by this module."
  value       = "${local.name}-sa"
}

output "iam_policy" {
  description = "The IAM policy name generated using the module name and the EKS cluster name."
  value       = format("%s-%s-IAM-Policy", local.name, var.eks_cluster_name)
}

output "namespace" {
  description = "The Kubernetes namespace where the Helm release is deployed."
  value       = local.default_helm_config.namespace
}

output "chart_version" {
  description = "The version of the Helm chart deployed by this module."
  value       = local.default_helm_config.version
}

output "repository" {
  description = "The Helm chart repository URL used to retrieve the Helm chart."
  value       = local.default_helm_config.repository
}