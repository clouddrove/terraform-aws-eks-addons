output "namespace" {
  value = local.default_helm_config.namespace
}

output "chart_version" {
  value = local.default_helm_config.version
}

output "repository" {
  value = local.default_helm_config.repository
}