locals {
  name = "tigera-operator"

  default_helm_config = {
    name             = local.name
    chart            = local.name
    repository       = "https://docs.tigera.io/calico/charts"
    version          = "v3.26.1"
    namespace        = "calico-system"
    create_namespace = true
    description      = "Calico helm Chart deployment configuration"
  }

  helm_config = merge(
    local.default_helm_config,
    var.helm_config
  )

  argocd_gitops_config = {
    enable = true
  }

}