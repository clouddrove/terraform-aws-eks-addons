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