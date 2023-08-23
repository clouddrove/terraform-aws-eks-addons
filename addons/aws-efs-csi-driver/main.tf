module "helm_addon" {
  source = "../helm"

  manage_via_gitops = var.manage_via_gitops
  helm_config       = local.helm_config
  addon_context     = var.addon_context

  depends_on = [kubernetes_namespace_v1.this]
  set_values = [
    {
      name  = "image.repository"
      value = "${local.image_repository[data.aws_region.current.name]}/eks/aws-efs-csi-driver"
    },
    {
      name  = "controller.serviceAccount.create"
      value = "false"
    },
    {
      name  = "controller.serviceAccount.name"
      value = "${local.name}-sa"
    },
    {
      name  = "replicaCount"
      value = "1"
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
  policy      = var.iampolicy_json_content != null ? var.iampolicy_json_content : <<-EOT
{
    "Version": "2012-10-17",
    "Statement": [
      {
        "Effect": "Allow",
        "Action": [
          "elasticfilesystem:DescribeAccessPoints",
          "elasticfilesystem:DescribeFileSystems",
          "elasticfilesystem:DescribeMountTargets",
          "ec2:DescribeAvailabilityZones"
        ],
        "Resource": "*"
      },
      {
        "Effect": "Allow",
        "Action": [
          "elasticfilesystem:CreateAccessPoint"
        ],
        "Resource": "*",
        "Condition": {
          "StringLike": {
            "aws:RequestTag/efs.csi.aws.com/cluster": "true"
          }
        }
      },
      {
        "Effect": "Allow",
        "Action": [
          "elasticfilesystem:TagResource"
        ],
        "Resource": "*",
        "Condition": {
          "StringLike": {
            "aws:ResourceTag/efs.csi.aws.com/cluster": "true"
          }
        }
      },
      {
        "Effect": "Allow",
        "Action": "elasticfilesystem:DeleteAccessPoint",
        "Resource": "*",
        "Condition": {
          "StringEquals": {
            "aws:ResourceTag/efs.csi.aws.com/cluster": "true"
          }
        }
      }
    ]
  }  
EOT
}

resource "kubernetes_namespace_v1" "this" {
  count = try(local.helm_config["create_namespace"], true) && local.helm_config["namespace"] != "kube-system" ? 1 : 0

  metadata {
    name = local.helm_config["namespace"]
  }
}
