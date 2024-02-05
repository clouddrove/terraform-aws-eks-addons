module "prometheus_cloudwatch_exporter_secret" {
  count  = var.secret_manifest != null ? 1 : 0
  source = "../helm"

  manage_via_gitops = var.manage_via_gitops
  helm_config       = local.helm_config
  addon_context     = var.addon_context

  set_values = [
    {
      name  = "aws.secret.name"
      value = "aws"
    }
  ]
  depends_on = [kubectl_manifest.secret_manifest]
}

module "prometheus_cloudwatch_exporter_role" {
  count  = var.secret_manifest == null ? 1 : 0
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
    }
  ]

  # -- IRSA Configurations
  irsa_config = {
    irsa_iam_policies           = [aws_iam_policy.policy.arn]
    irsa_iam_role_name          = "${local.name}-${var.eks_cluster_name}"
    create_kubernetes_namespace = false
    kubernetes_service_account  = "${local.name}-sa"
    kubernetes_namespace        = local.default_helm_config.namespace
    eks_oidc_provider_arn       = var.addon_context.eks_oidc_provider_arn
    account_id                  = var.addon_context.aws_caller_identity_account_id
  }
}

# Secret for AWS Authentication with cloudwatch exporter
resource "kubectl_manifest" "secret_manifest" {
  count      = var.secret_manifest != null ? 1 : 0
  yaml_body  = var.secret_manifest
  depends_on = [kubernetes_namespace.prometheus_cloudwatch_exporter_namespace]
}

resource "kubernetes_namespace" "prometheus_cloudwatch_exporter_namespace" {
  metadata {
    name = local.default_helm_config.namespace
  }
}

resource "aws_iam_policy" "policy" {
  name        = "${local.name}-${var.eks_cluster_name}"
  path        = "/"
  description = "IAM Policy used by ${local.name}-${var.eks_cluster_name} IAM Role"
  policy      = var.iampolicy_json_content != null ? var.iampolicy_json_content : <<-EOT
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "AllowCloudwatch",
            "Effect": "Allow",
            "Action": [
                "cloudwatch:ListMetrics",
                "cloudwatch:GetMetricStatistics",
                "cloudwatch:GetMetricData"
            ],
            "Resource": "*"
        },
        {
            "Sid": "AllowResourceTagging",
            "Effect": "Allow",
            "Action": [
                "tag:GetResources"
            ],
            "Resource": "*"
        }
    ]
}
EOT
}