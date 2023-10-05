module "helm_addon" {
  source = "../helm"

  manage_via_gitops = var.manage_via_gitops
  helm_config       = local.helm_config
  addon_context     = var.addon_context

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
    irsa_iam_policies                 = [aws_iam_policy.policy.arn]
    irsa_iam_role_name                = "${local.name}-${var.eks_cluster_name}"
    create_kubernetes_service_account = true
    kubernetes_service_account        = "${local.name}-sa"
    kubernetes_namespace              = local.default_helm_config.namespace
    eks_oidc_provider_arn             = replace(data.aws_eks_cluster.eks_cluster.identity[0].oidc[0].issuer, "https://", "")
    account_id                        = var.account_id
  }

  irsa_assume_role_policy = var.external_secrets_extra_configs.irsa_assume_role_policy

}

resource "aws_iam_policy" "policy" {
  name        = "${local.name}-${var.eks_cluster_name}"
  path        = "/"
  description = "IAM Policy used by ${local.name}-${var.eks_cluster_name} IAM Role"
  policy      = data.aws_iam_policy_document.iam-policy.json
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
      "arn:aws:secretsmanager:${data.aws_region.current.name}:${var.account_id}:secret:${var.external_secrets_extra_configs.secret_manager_name}*",
    ]
  }
}

module "secrets_manager" {
  source  = "clouddrove/secrets-manager/aws"
  version = "2.0.0"

  count = try(var.external_secrets_extra_configs.create_secret_manager, true) ? 1 : 0
  name  = "secrets-manager"
  secrets = [
    {
      name        = try(var.external_secrets_extra_configs.secret_manager_name, "external_secret")
      description = try(var.external_secrets_extra_configs.secret_manager_description, "AWS EKS external-secrets helm addon.")
      secret_key_value = {
        external_secret = "external_secret_addon"
      }
      recovery_window_in_days = try(var.external_secrets_extra_configs.recovery_window_in_days, 7)
    }
  ]
}
