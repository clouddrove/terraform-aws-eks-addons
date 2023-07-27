module "helm_addon" {
  source = "../helm"

  manage_via_gitops = var.manage_via_gitops
  helm_config       = local.helm_config
  addon_context     = var.addon_context

}

resource "null_resource" "kiali_token" {
  depends_on = [module.helm_addon]
  provisioner "local-exec" {
    command = "kubectl apply -f ../../addons/${local.name}/config/kiali_secret.yaml -n ${local.default_helm_config.namespace}"
  }
}

resource "null_resource" "kiali_virtualservice" {
  depends_on = [module.helm_addon]
  provisioner "local-exec" {
    command = "kubectl apply -f ${var.kiali_manifests.kiali_virtualservice_file_path} -n ${local.default_helm_config.namespace}"
  }
}

resource "null_resource" "enable_monitoring" {
  count      = var.kiali_manifests.enable_monitoring ? 1 : 0
  depends_on = [null_resource.kiali_virtualservice]
  provisioner "local-exec" {
    command = "kubectl apply -f ../../addons/${local.name}/config/monitoring/grafana.yaml  -f ../../addons/${local.name}/config/monitoring/jaeger.yaml -f ../../addons/${local.name}/config/monitoring/prometheus.yaml  -n ${local.default_helm_config.namespace}"
  }
}
