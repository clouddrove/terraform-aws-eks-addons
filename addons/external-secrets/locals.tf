locals {
  name = "external-secrets"

  default_helm_config = {
    name        = local.name
    chart       = local.name
    repository  = "https://charts.external-secrets.io/"
    version     = "0.9.2"
    namespace   = "kube-system"
    description = "external-secrets helm Chart deployment configuration"
  }

  helm_config = merge(
    local.default_helm_config,
    var.helm_config
  )

  argocd_gitops_config = {
    enable = true
  }
}
