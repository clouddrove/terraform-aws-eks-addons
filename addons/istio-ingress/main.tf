module "istio_base" {
  source = "../helm"
  count  = try(var.istio_ingress_extra_configs.install_istiobase, true) ? 1 : 0

  manage_via_gitops = var.manage_via_gitops
  helm_config       = local.istio_base.helm_config
  addon_context     = var.addon_context

}

module "istiod" {
  source = "../helm"
  count  = try(var.istio_ingress_extra_configs.install_istiod, true) ? 1 : 0

  manage_via_gitops = var.manage_via_gitops
  helm_config       = local.istiod.helm_config
  addon_context     = var.addon_context

  depends_on = [module.istio_base]
}

module "istio_ingress" {
  source = "../helm"

  manage_via_gitops = var.manage_via_gitops
  helm_config       = local.helm_config
  addon_context     = var.addon_context

  depends_on = [module.istiod]
}

resource "kubectl_manifest" "istio_ingress_manifest" {
  count      = length(var.istio_manifests.istio_ingress_manifest_file_path)
  depends_on = [module.istio_ingress]
  yaml_body  = file(var.istio_manifests.istio_ingress_manifest_file_path[count.index])
}

resource "kubectl_manifest" "istio_gateway_manifest" {
  count      = length(var.istio_manifests.istio_gateway_manifest_file_path)
  depends_on = [kubectl_manifest.istio_ingress_manifest]
  yaml_body  = file(var.istio_manifests.istio_gateway_manifest_file_path[count.index])
}
