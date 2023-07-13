locals {
  name = "cluster-autoscaler"

  default_helm_config = {
    name        = local.name
    chart       = local.name
    repository  = "https://kubernetes.github.io/autoscaler"
    version     = "9.29.0"
    namespace   = "kube-system"
    description = "Cluster Autoscaler helm Chart deployment configuration"
  }

  helm_config = merge(
    local.default_helm_config,
    var.helm_config
  )

  argocd_gitops_config = {
    enable = true
  }
}
