module "metrics_server" {
  count             = var.enable_metrics_server ? 1 : 0
  source            = "./metrics-server"
  helm_config       = var.metrics_server_helm_config != null ? var.metrics_server_helm_config : [file("${path.module}/metrics_server/config/metrics_server.yaml")]
  manage_via_gitops = var.argocd_manage_add_ons
  addon_context     = local.addon_context
}
