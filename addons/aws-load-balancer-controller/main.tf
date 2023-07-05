module "helm_addon" {
  source = "../helm"

  manage_via_gitops = var.manage_via_gitops
  helm_config       = local.helm_config
  addon_context     = var.addon_context

  depends_on = [kubernetes_namespace_v1.this]
  set_values = [
    {
      name  = "clusterName"
      value = var.eks_cluster_name
    },
    {
      name  = "controller.serviceAccount.create"
      value = "true"
    },
    {
      name  = "controller.serviceAccount.name"
      value = "${local.name}-sa"
    },
    {
      name  = "controller.serviceAccount.annotations.eks\\.amazonaws\\.com/role-arn"
      value = aws_iam_role.aws_load_balancer_controller.arn
    },
    {
      # Using the same service account for both the nodes and controllers,
      # and already creating the service account in the controller config
      # above.
      name  = "node.serviceAccount.create"
      value = "false"
    },
    {
      name  = "node.serviceAccount.name"
      value = "${local.name}-sa"
    },
    {
      name  = "node.serviceAccount.annotations.eks\\.amazonaws\\.com/role-arn"
      value = aws_iam_role.aws_load_balancer_controller.arn
    }
  ]

}

resource "kubernetes_namespace_v1" "this" {
  count = try(local.helm_config["create_namespace"], true) && local.helm_config["namespace"] != "kube-system" ? 1 : 0

  metadata {
    name = local.helm_config["namespace"]
  }
}
