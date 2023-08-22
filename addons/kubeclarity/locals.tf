locals {
  name = "kubeclarity"

  default_helm_config = {
    name             = local.name
    chart            = local.name
    repository       = "https://openclarity.github.io/kubeclarity"
    version          = "v2.19.0"
    namespace        = "kubeclarity"
    create_namespace = true
    description      = "Kubeclarity helm Chart deployment configuration"
  }

  helm_config = merge(
    local.default_helm_config,
    var.helm_config
  )

  argocd_gitops_config = {
    enable = true
  }
}
