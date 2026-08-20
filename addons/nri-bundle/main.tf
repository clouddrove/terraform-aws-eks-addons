module "helm_addon" {
  source = "../helm"

  helm_config   = local.helm_config
  addon_context = var.addon_context

  set_values = [
    {
      name  = "global.cluster"
      value = var.eks_cluster_name
    }
  ]
}