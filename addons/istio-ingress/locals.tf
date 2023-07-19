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

  istio_ingress = {
    helm_config = merge(
      var.istio_ingress_default_helm_config,
      var.helm_config
    )
  }

  argocd_gitops_config = {
    enable = true
  }
}
