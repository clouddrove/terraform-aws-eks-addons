module "helm_addon" {
  source = "../helm"

  manage_via_gitops = var.manage_via_gitops
  helm_config       = local.helm_config
  addon_context     = var.addon_context

}

resource "kubectl_manifest" "kiali_token" {
  depends_on = [module.helm_addon]
  yaml_body  = <<EOT
apiVersion: v1
kind: Secret
metadata:
  name: kiali-token
  namespace: istio-system
  annotations:
    kubernetes.io/service-account.name: kiali
type: kubernetes.io/service-account-token  
  EOT
}

resource "kubectl_manifest" "kiali_virtualservice" {
  depends_on = [module.helm_addon]
  yaml_body  = file("${var.kiali_manifests.kiali_virtualservice_file_path}")
}