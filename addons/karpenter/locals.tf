locals {
  name = "karpenter"

  default_helm_config = {
    name        = local.name
    chart       = local.name
    repository  = "https://charts.karpenter.sh/"
    version     = "0.16.3"
    namespace   = "kube-system"
    description = "Karpenter helm Chart deployment configuration"
  }

  helm_config = merge(
    local.default_helm_config,
    var.helm_config
  )

  argocd_gitops_config = {
    enable = true
  }
}
