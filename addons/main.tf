module "metrics_server" {
  count             = var.enable_metrics_server ? 1 : 0
  source            = "./metrics-server"
  helm_config       = var.metrics_server_helm_config != null ? var.metrics_server_helm_config : {}
  manage_via_gitops = var.manage_via_gitops
  addon_context     = local.addon_context
}
