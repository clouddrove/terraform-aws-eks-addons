locals {
  name = "ingress-nginx"

  default_helm_config = {
    name        = local.name
    chart       = local.name
    repository  = "https://kubernetes.github.io/ingress-nginx"
    version     = "4.6.1"
    namespace   = "kube-system"
    description = "Nginx Ingress helm Chart deployment configuration"
  }

  helm_config = merge(
    local.default_helm_config,
    var.helm_config
  )

  argocd_gitops_config = {
    enable = true
  }
}