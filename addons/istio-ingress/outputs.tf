# output "namespace" {
#   value = var.istio_ingress_default_helm_config.namespace
# }

# output "chart_version" {
#   value = var.istio_ingress_default_helm_config.version
# }

# output "repository" {
#   value = var.istio_ingress_default_helm_config.repository
# }

output "namespace" {
  value = local.default_helm_config.namespace
}

output "chart_version" {
  value = local.default_helm_config.version
}

output "repository" {
  value = local.default_helm_config.repository
}