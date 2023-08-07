module "helm_addon" {
  source = "../helm"

  manage_via_gitops = var.manage_via_gitops
  helm_config       = local.helm_config
  addon_context     = var.addon_context

  depends_on = [kubernetes_namespace.this]

}

resource "kubernetes_namespace" "this" {
  count = try(local.helm_config["create_namespace"], true) && local.helm_config["namespace"] != "kube-system" ? 1 : 0

  metadata {
    name = local.helm_config["namespace"]
  }
}

resource "kubectl_manifest" "calico_node" {
  depends_on = [data.aws_eks_cluster.eks_cluster]
  yaml_body  = file("../../addons/calico-tigera/config/calico-deployment.yaml")
}