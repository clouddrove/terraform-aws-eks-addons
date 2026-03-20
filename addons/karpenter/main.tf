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
      name  = "settings.clusterName"
      value = var.eks_cluster_name
    },
    {
      name  = "settings.clusterEndpoint"
      value = terraform_data.endpoint.output
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

resource "kubectl_manifest" "ec2_nodeclass" {
  depends_on = [
    module.helm_addon,
    aws_iam_policy.policy
  ]
  yaml_body = var.karpenter_extra_configs.ec2_nodeclass_yaml
}
resource "kubectl_manifest" "nodepools" {
  depends_on = [
    module.helm_addon,
    kubectl_manifest.ec2_nodeclass
  ]
  yaml_body = var.karpenter_extra_configs.nodepool_yaml
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
                "ssm:GetParameter",
                "ec2:DescribeImages",
                "ec2:RunInstances",
                "ec2:DescribeSubnets",
                "ec2:DescribeSecurityGroups",
                "ec2:DescribeLaunchTemplates",
                "ec2:DescribeInstances",
                "ec2:DescribeInstanceTypes",
                "ec2:DescribeInstanceTypeOfferings",
                "ec2:DeleteLaunchTemplate",
                "ec2:CreateTags",
                "ec2:CreateLaunchTemplate",
                "ec2:CreateFleet",
                "ec2:DescribeSpotPriceHistory",
                "pricing:GetProducts"
            ],
            "Effect": "Allow",
            "Resource": "*",
            "Sid": "Karpenter"
        },
        {
            "Action": "ec2:TerminateInstances",
            "Condition": {
                "StringLike": {
                    "ec2:ResourceTag/karpenter.sh/nodepool": "*"
                }
            },
            "Effect": "Allow",
            "Resource": "*",
            "Sid": "ConditionalEC2Termination"
        },
        {
            "Effect": "Allow",
            "Action": "iam:PassRole",
            "Resource": "${var.karpenter_extra_configs.eks_nodegroup_iam_role_arn}",
            "Sid": "PassNodeIAMRole"
        },
        {
            "Effect": "Allow",
            "Action": "eks:DescribeCluster",
            "Resource": "arn:aws:eks:${data.aws_region.current.region}:${data.aws_caller_identity.current.account_id}:cluster/${var.eks_cluster_name}",
            "Sid": "EKSClusterEndpointLookup"
        },
        {
            "Sid": "AllowScopedInstanceProfileCreationActions",
            "Effect": "Allow",
            "Resource": "*",
            "Action": [
                "iam:CreateInstanceProfile"
            ],
            "Condition": {
                "StringEquals": {
                    "aws:RequestTag/kubernetes.io/cluster/${var.eks_cluster_name}": "owned",
                    "aws:RequestTag/topology.kubernetes.io/region": "${data.aws_region.current.region}"
                },
                "StringLike": {
                    "aws:RequestTag/karpenter.k8s.aws/ec2nodeclass": "*"
                }
            }
        },
        {
            "Sid": "AllowScopedInstanceProfileTagActions",
            "Effect": "Allow",
            "Resource": "*",
            "Action": [
                "iam:TagInstanceProfile"
            ],
            "Condition": {
                "StringEquals": {
                    "aws:ResourceTag/kubernetes.io/cluster/${var.eks_cluster_name}": "owned",
                    "aws:ResourceTag/topology.kubernetes.io/region": "${data.aws_region.current.region}",
                    "aws:RequestTag/kubernetes.io/cluster/${var.eks_cluster_name}": "owned",
                    "aws:RequestTag/topology.kubernetes.io/region": "${data.aws_region.current.region}"
                },
                "StringLike": {
                    "aws:ResourceTag/karpenter.k8s.aws/ec2nodeclass": "*",
                    "aws:RequestTag/karpenter.k8s.aws/ec2nodeclass": "*"
                }
            }
        },
        {
            "Sid": "AllowScopedInstanceProfileActions",
            "Effect": "Allow",
            "Resource": "*",
            "Action": [
                "iam:AddRoleToInstanceProfile",
                "iam:RemoveRoleFromInstanceProfile",
                "iam:DeleteInstanceProfile"
            ],
            "Condition": {
                "StringEquals": {
                    "aws:ResourceTag/kubernetes.io/cluster/${var.eks_cluster_name}": "owned",
                    "aws:ResourceTag/topology.kubernetes.io/region": "${data.aws_region.current.region}"
                },
                "StringLike": {
                    "aws:ResourceTag/karpenter.k8s.aws/ec2nodeclass": "*"
                }
            }
        },
        {
            "Sid": "AllowInstanceProfileReadActions",
            "Effect": "Allow",
            "Resource": "*",
            "Action": "iam:GetInstanceProfile"
        },
        {
            "Sid": "AllowUnscopedInstanceProfileListAction",
            "Effect": "Allow",
            "Resource": "*",
            "Action": "iam:ListInstanceProfiles"
        }
    ],
    "Version": "2012-10-17"
}
  EOT
}
