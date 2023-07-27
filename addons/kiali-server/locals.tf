locals {
  name = "kiali-server"

  default_helm_config = {
    name        = local.name
    chart       = local.name
    repository  = "https://kiali.org/helm-charts"
    version     = "1.71.0"
    namespace   = "istio-system"
    description = "Kiali Dashboard helm Chart deployment configuration"
  }

  helm_config = merge(
    local.default_helm_config,
    var.helm_config
  )

  argocd_gitops_config = {
    enable = true
  }
}
