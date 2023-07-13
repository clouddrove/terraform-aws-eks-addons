locals {
  name = "aws-load-balancer-controller"

  default_helm_config = {
    name        = local.name
    chart       = local.name
    repository  = "https://aws.github.io/eks-charts"
    version     = "1.5.3"
    namespace   = "kube-system"
    description = "AWS Load Balancer Controller helm Chart deployment configuration"
  }

  helm_config = merge(
    local.default_helm_config,
    var.helm_config
  )

  argocd_gitops_config = {
    enable = true
  }
}
