output "namespace" {
  description = "The Kubernetes namespace where the Helm release is deployed."
  value       = local.default_helm_config.namespace
}

output "chart_version" {
  description = "The version of the Helm chart deployed by this module."
  value       = local.default_helm_config.version
}

output "repository" {
  description = "The Helm chart repository URL used to fetch the chart."
  value       = local.default_helm_config.repository
}