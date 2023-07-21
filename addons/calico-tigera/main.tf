module "helm_addon" {
  source = "../helm"

  manage_via_gitops = var.manage_via_gitops
  helm_config       = local.helm_config
  addon_context     = var.addon_context

  depends_on = [kubernetes_namespace_v1.this]
  set_values = [
    {
      name  = "image.repository"
      value = "${local.image_repository[data.aws_region.current.name]}/eks/calico-tigera"
    },
    {
      name  = "controller.serviceAccount.create"
      value = "false"
    },
    {
      name  = "controller.serviceAccount.name"
      value = "${local.name}-sa"
    }
  ]

  # -- IRSA Configurations
  irsa_config = {
    irsa_iam_policies                 = ["${aws_iam_policy.policy.arn}"]
    irsa_iam_role_name                = "${local.name}-${var.eks_cluster_name}-IAM-Role"
    create_kubernetes_service_account = true
    kubernetes_service_account        = "${local.name}-sa"
    kubernetes_namespace              = local.default_helm_config.namespace
    eks_oidc_provider_arn             = replace("${data.aws_eks_cluster.eks_cluster.identity[0].oidc[0].issuer}", "https://", "")
    account_id                        = var.account_id
  }

}

resource "aws_iam_policy" "policy" {
  name        = "${local.name}-${var.eks_cluster_name}-IAM-Policy"
  path        = "/"
  description = "IAM Policy used by ${local.name}-${var.eks_cluster_name} IAM Role"
  policy      = file("../../addons/${local.name}-${var.eks_cluster_name}/policy.json")
}

resource "kubernetes_namespace_v1" "this" {
  count = try(local.helm_config["create_namespace"], true) && local.helm_config["namespace"] != "kube-system" ? 1 : 0

  metadata {
    name = local.helm_config["namespace"]
  }
}
