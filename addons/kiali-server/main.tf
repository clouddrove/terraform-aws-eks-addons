module "helm_addon" {
  source = "../helm"

  manage_via_gitops = var.manage_via_gitops
  helm_config       = local.helm_config
  addon_context     = var.addon_context

}

resource "kubectl_manifest" "kiali_token" {
  depends_on = [module.helm_addon]
  yaml_body  = file("../../addons/${local.name}/config/kiali_secret.yaml")
}

resource "kubectl_manifest" "kiali_virtualservice" {
  depends_on = [module.helm_addon]
  yaml_body  = file("${var.kiali_manifests.kiali_virtualservice_file_path}")
}

resource "kubectl_manifest" "prometheus" {
  count      = var.kiali_manifests.enable_monitoring ? 1 : 0
  depends_on = [kubectl_manifest.kiali_virtualservice]
  yaml_body  = file("../../addons/${local.name}/config/monitoring/prometheus.yaml")
}

resource "kubectl_manifest" "grafana" {
  count      = var.kiali_manifests.enable_monitoring ? 1 : 0
  depends_on = [kubectl_manifest.kiali_virtualservice]
  yaml_body  = file("../../addons/${local.name}/config/monitoring/grafana.yaml")
}

resource "kubectl_manifest" "jaeger" {
  count      = var.kiali_manifests.enable_monitoring ? 1 : 0
  depends_on = [kubectl_manifest.kiali_virtualservice]
  yaml_body  = file("../../addons/${local.name}/config/monitoring/jaeger.yaml")
}
