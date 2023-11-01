module "helm_addon" {
  source = "../helm"

  manage_via_gitops = var.manage_via_gitops
  helm_config       = local.helm_config
  addon_context     = var.addon_context
  # set_values = [
  #   {
  #     name  = "serviceAccounts.server.create"
  #     value = "false"
  #   },
  #   {
  #     name  = "serviceAccounts.server.name"
  #     value = "${local.name}-sa"
  #   },
  # ]
}