module "helm_addon" {
  source = "../helm"

  manage_via_gitops = var.manage_via_gitops
  helm_config       = local.helm_config
  addon_context     = var.addon_context

  set_values = [
    {
      name  = "serviceAccount.server.create"
      value = false
    },
    {
      name  = "serviceAccount.server.name"
      value = "${local.name}-sa"
    },
    {
      name  = "configuration.backupStorageLocation[0].bucket"
      value = try(var.velero_extra_configs.bucket_name, "velero-addons")
    }
  ]

  # -- IRSA Configurations
  irsa_config = {
    create_kubernetes_namespace       = local.default_helm_config.create_namespace
    create_kubernetes_service_account = true
    kubernetes_namespace              = local.default_helm_config.namespace
    kubernetes_service_account        = "${local.name}-sa"
    irsa_iam_policies                 = [aws_iam_policy.policy.arn]
    irsa_iam_role_name                = "${local.name}-${var.eks_cluster_name}"
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
                "ec2:DescribeVolumes",
                "ec2:DescribeSnapshots",
                "ec2:CreateTags",
                "ec2:CreateVolume",
                "ec2:CreateSnapshot",
                "ec2:DeleteSnapshot"
            ],
            "Resource": "*"
        },
        {
            "Effect": "Allow",
            "Action": [
                "s3:GetObject",
                "s3:DeleteObject",
                "s3:PutObject",
                "s3:AbortMultipartUpload",
                "s3:ListMultipartUploadParts"
            ],
            "Resource": [
                "arn:aws:s3:::${try(var.velero_extra_configs.bucket_name, "velero-addons-${var.eks_cluster_name}")}/*"
            ]
        },
        {
            "Effect": "Allow",
            "Action": [
                "s3:ListBucket"
            ],
            "Resource": [
                "arn:aws:s3:::${try(var.velero_extra_configs.bucket_name, "velero-addons-${var.eks_cluster_name}")}"
            ]
        }
    ]
}
  EOT
}
