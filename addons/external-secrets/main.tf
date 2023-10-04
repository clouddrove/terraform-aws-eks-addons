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

  irsa_assume_role_policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Principal" : {
          "Federated" : "arn:aws:iam::${data.aws_caller_identity.current.account_id}:oidc-provider/${replace(data.aws_eks_cluster.eks_cluster.identity[0].oidc[0].issuer, "https://", "")}"
        },
        "Action" : "sts:AssumeRoleWithWebIdentity",
        "Condition" : {
          "StringLike" : {
            "${replace(data.aws_eks_cluster.eks_cluster.identity[0].oidc[0].issuer, "https://", "")}:aud" : "sts.amazonaws.com"
          }
        }
      }
    ]
  })
}

resource "aws_iam_policy" "policy" {
  name        = "${local.name}-${var.eks_cluster_name}"
  path        = "/"
  description = "IAM Policy used by ${local.name}-${var.eks_cluster_name} IAM Role"
  policy      = var.iampolicy_json_content != null ? var.iampolicy_json_content : <<-EOT
{
    "Statement": [
        {
            "Action": [
                "secretsmanager:GetSecretValue",
                "secretsmanager:DescribeSecret"
            ],
            "Effect": "Allow",
            "Resource": "arn:aws:secretsmanager:${data.aws_region.current.name}:${var.account_id}:secret:${try(var.external_secrets_extra_configs.secret_manager_name, "external_secrets_addon")}*",
            "Sid": "ExternalSecretsDefault"
        }
    ],
    "Version": "2012-10-17"
}  
  EOT
}

module "secrets_manager" {
  source  = "clouddrove/secrets-manager/aws"
  version = "2.0.0"

  count = try(var.external_secrets_extra_configs.create_secret_manager, true) ? 1 : 0
  name  = "secrets-manager"
  secrets = [
    {
      name        = try(var.external_secrets_extra_configs.secret_manager_name, "external_secrets_addon")
      description = try(var.external_secrets_extra_configs.secret_manager_description, "AWS EKS external-secrets helm addon.")
      secret_key_value = {
        external_secret = "external_secret_addon_data"
      }
      recovery_window_in_days = try(var.external_secrets_extra_configs.recovery_window_in_days, 7)
    }
  ]
}
