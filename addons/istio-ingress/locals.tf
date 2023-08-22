locals {
  istio_base = {
    helm_config = {
      name        = "base"
      chart       = "base"
      repository  = "https://istio-release.storage.googleapis.com/charts"
      version     = "1.18.0"
      namespace   = "istio-system"
      description = "Istio helm Chart deployment configuration"
    }
  }

  istiod = {
    helm_config = {
      name        = "istiod"
      chart       = "istiod"
      repository  = "https://istio-release.storage.googleapis.com/charts"
      version     = "1.18.0"
      namespace   = "istio-system"
      description = "Istio helm Chart deployment configuration"
    }
  }

  default_helm_config = {
    name        = "istio-ingressgateway"
    chart       = "gateway"
    repository  = "https://istio-release.storage.googleapis.com/charts"
    version     = "1.18.0"
    namespace   = "istio-system"
    description = "Istio Ingress helm Chart deployment configuration"
  }
  istio_ingress_extra_configs = var.istio_ingress_extra_configs

  helm_config = merge(
    local.default_helm_config,
    var.helm_config,
    local.istio_ingress_extra_configs
  )

  argocd_gitops_config = {
    enable = true
  }
}
