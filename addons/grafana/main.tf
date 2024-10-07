module "helm_addon" {
  source = "../helm"

  manage_via_gitops = var.manage_via_gitops
  helm_config       = local.helm_config
  addon_context     = var.addon_context
}

resource "kubectl_manifest" "grafana_virtualservice" {
  count      = var.grafana_manifests.grafana_virtualservice_file_path != "" ? 1 : 0
  yaml_body  = file(var.grafana_manifests.grafana_virtualservice_file_path)
  depends_on = [module.helm_addon]
}
