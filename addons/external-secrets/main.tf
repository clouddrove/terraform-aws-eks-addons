module "helm_addon" {
  source = "../helm"

  manage_via_gitops = var.manage_via_gitops
  helm_config       = local.helm_config
  addon_context     = var.addon_context

  depends_on = [kubernetes_namespace_v1.this]
  set_values = [
    {
      name  = "serviceAccount.create"
      value = "false"
    },
    {
      name  = "serviceAccount.name"
      value = "${local.name}-sa"
    },
    {
      name  = "webhook.rbac.serviceAccount.create"
      value = "false"
    },
    {
      name  = "webhook.rbac.serviceAccount.name"
      value = "${local.name}-sa"
    },
    {
      name  = "certController.serviceAccount.create"
      value = "false"
    },
    {
      name  = "certController.serviceAccount.name"
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
  policy      = data.aws_iam_policy_document.iam-policy.json
}

resource "kubernetes_namespace_v1" "this" {
  count = try(local.helm_config["create_namespace"], true) && local.helm_config["namespace"] != "kube-system" ? 1 : 0

  metadata {
    name = local.helm_config["namespace"]
  }
}


data "aws_iam_policy_document" "iam-policy" {
  version = "2012-10-17"

  statement {
    sid    = "VisualEditor0"
    effect = "Allow"
    actions = [
      "secretsmanager:GetSecretValue",
      "secretsmanager:DescribeSecret",
    ]
    resources = [
      "arn:aws:secretsmanager:${data.aws_region.current.name}:${var.account_id}:secret:${var.externalsecrets_manifest.secret_manager_name}*",
    ]
  }
}

resource "kubectl_manifest" "secret_store" {
  depends_on = [module.helm_addon]
  yaml_body  = file("${var.externalsecrets_manifest.secret_store_manifest_file_path}")
}

resource "kubectl_manifest" "external_secrets" {
  depends_on = [kubectl_manifest.secret_store, module.secrets_manager]
  yaml_body  = file("${var.externalsecrets_manifest.external_secrets_manifest_file_path}")
}

module "secrets_manager" {
  source  = "clouddrove/secrets-manager/aws"
  version = "1.3.0"

  name = "secrets-manager"
  secrets = [
    {
      name        = "${var.externalsecrets_manifest.secret_manager_name}"
      description = "This is a key/value secret"
      secret_key_value = {
        do_not_delete_this_key = "do_not_delete_this_value"
      }
      recovery_window_in_days = 7
    }
  ]
}
