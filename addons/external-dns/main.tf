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
            "Effect": "Allow",
            "Action": [
                "route53:ChangeResourceRecordSets"
            ],
            "Resource": [
                "arn:aws:route53:::hostedzone/*"
            ]
        },
        {
            "Effect": "Allow",
            "Action": [
                "route53:ListHostedZones",
                "route53:ListResourceRecordSets",
                "route53:ListTagsForResource"
            ],
            "Resource": [
                "*"
            ]
        }
    ]
}
  EOT
}