locals {
  name = "prometheus"

  default_helm_config = {
    name        = local.name
    chart       = local.name
    repository  = "https://prometheus-community.github.io/helm-charts"
    version     = "23.3.0"
    namespace   = "prometheus"
    description = "prometheus helm Chart deployment configuration"
  }

  helm_config = merge(
    local.default_helm_config,
    var.helm_config
  )

  argocd_gitops_config = {
    enable = true
  }
}