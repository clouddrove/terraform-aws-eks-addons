module "helm_addon" {
  source = "../helm"

  helm_config   = local.helm_config
  addon_context = var.addon_context
}

resource "kubectl_manifest" "kube_prometheus_stack_virtualservice" {
  count      = length(var.kube_prometheus_stack_manifests.kube_prometheus_stack_virtualservice_file_path)
  depends_on = [module.helm_addon]
  yaml_body  = file(var.kube_prometheus_stack_manifests.kube_prometheus_stack_virtualservice_file_path[count.index])
}