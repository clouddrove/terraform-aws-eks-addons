module "istio_base" {
  source = "../helm"

  manage_via_gitops = var.manage_via_gitops
  helm_config       = local.istio_base.helm_config
  addon_context     = var.addon_context

  depends_on = [kubernetes_namespace_v1.istio_system]
}

module "istiod" {
  source = "../helm"

  manage_via_gitops = var.manage_via_gitops
  helm_config       = local.istiod.helm_config
  addon_context     = var.addon_context

  depends_on = [
    module.istio_base,
    kubernetes_namespace_v1.istio_system
  ]
}

module "istio_ingress" {
  source = "../helm"

  manage_via_gitops = var.manage_via_gitops
  helm_config       = local.istio_ingress.helm_config
  addon_context     = var.addon_context

  depends_on = [
    module.istiod,
    kubernetes_namespace_v1.istio_system
  ]
}

resource "kubectl_manifest" "istio_ingress_manifest" {
  depends_on = [module.istio_ingress]
  yaml_body  = file("${var.istio_manifests.istio_ingress_manifest_file_path}")
}

resource "kubectl_manifest" "istio_gateway_manifest" {
  depends_on = [kubectl_manifest.istio_ingress_manifest]
  yaml_body  = file("${var.istio_manifests.istio_gateway_manifest_file_path}")
}

resource "kubernetes_namespace_v1" "istio_system" {
  count = try(local.istio_base.helm_config["create_namespace"], true) && local.istio_base.helm_config["namespace"] != "kube-system" ? 1 : 0

  metadata {
    name = local.istio_base.helm_config["namespace"]
  }
}
