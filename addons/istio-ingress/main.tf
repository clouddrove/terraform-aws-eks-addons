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

resource "null_resource" "istio_ingress_manifest" {
  depends_on = [module.istio_ingress]
  provisioner "local-exec" {
    command = "kubectl apply -f ${var.istio_manifests.istio_ingress_manifest_file_path} -n ${var.istio_ingress_default_helm_config.namespace}"
  }
}

resource "null_resource" "istio_gateway_manifest" {
  depends_on = [null_resource.istio_ingress_manifest]
  provisioner "local-exec" {
    command = "kubectl apply -f ${var.istio_manifests.istio_gateway_manifest_file_path} -n ${var.istio_ingress_default_helm_config.namespace}"
  }
}

resource "kubernetes_namespace_v1" "istio_system" {
  count = try(local.istio_base.helm_config["create_namespace"], true) && local.istio_base.helm_config["namespace"] != "kube-system" ? 1 : 0

  metadata {
    name = local.istio_base.helm_config["namespace"]
  }
}

