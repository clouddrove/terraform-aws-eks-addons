locals {
  name = "aws-ebs-csi-driver"

  default_helm_config = {
    name        = local.name
    chart       = local.name
    repository  = "https://kubernetes-sigs.github.io/aws-ebs-csi-driver"
    version     = "2.20.0"
    namespace   = "kube-system"
    description = "AWS EBS CSI Driver helm Chart deployment configuration"
  }

  helm_config = merge(
    local.default_helm_config,
    var.helm_config
  )

  argocd_gitops_config = {
    enable = true
  }
}
