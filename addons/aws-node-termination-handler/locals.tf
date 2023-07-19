locals {
  name = "aws-node-termination-handler"

  default_helm_config = {
    name        = local.name
    chart       = local.name
    repository  = "https://aws.github.io/eks-charts/"
    version     = "0.21.0"
    namespace   = "kube-system"
    description = "AWS Node Termination Handler helm Chart deployment configuration"
  }

  helm_config = merge(
    local.default_helm_config,
    var.helm_config
  )

  argocd_gitops_config = {
    enable = true
  }
}
