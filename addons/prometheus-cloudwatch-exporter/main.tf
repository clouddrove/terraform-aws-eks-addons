module "prometheus_cloudwatch_exporter_secret" {
  count  = length(var.secret_manifest)
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

  depends_on = [resource.kubectl_manifest.secret_manifest]
}

module "prometheus_cloudwatch_exporter_role" {
  # count  = var.secret_manifest == [] && try(var.prometheus_cloudwatch_exporter_extra_configs.role_name, "") != "" ? 1 : 0
  count  = var.secret_manifest == [] ? 1 : 0
  source = "../helm"

  manage_via_gitops = var.manage_via_gitops
  helm_config       = local.helm_config
  addon_context     = var.addon_context

  set_values = [
    {
      name  = "aws.role"
      value = local.role_name
    }
  ]

  depends_on = [resource.kubectl_manifest.secret_manifest]
}

# Secret for AWS Authentication with cloudwatch exporter
resource "kubectl_manifest" "secret_manifest" {
  count     = length(var.secret_manifest)
  yaml_body = file(var.secret_manifest[count.index])
}

# Role for AWS Authentication
data "aws_iam_policy_document" "role" {
  # count = var.secret_manifest == [] && try(var.prometheus_cloudwatch_exporter_extra_configs.role_name, "") != "" ? 1 : 0
  count = var.secret_manifest == [] ? 1 : 0
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["eks.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "role" {
  # count              = var.secret_manifest == [] && try(var.prometheus_cloudwatch_exporter_extra_configs.role_name, "") != "" ? 1 : 0
  count              = var.secret_manifest == [] ? 1 : 0
  name               = local.role_name
  assume_role_policy = data.aws_iam_policy_document.role[0].json
}

# Policy of the Role
resource "aws_iam_policy" "policy" {
  # count       = var.secret_manifest == [] && try(var.prometheus_cloudwatch_exporter_extra_configs.role_name, "") != "" ? 1 : 0
  count       = var.secret_manifest == [] ? 1 : 0
  name        = local.policy_name
  path        = "/"
  description = "IAM Policy used by ${local.name}-${var.eks_cluster_name} IAM Role"
  policy      = var.iampolicy_json_content != null ? var.iampolicy_json_content : <<-EOT
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "AllowReadingMetricsFromCloudWatch",
            "Effect": "Allow",
            "Action": [
                "cloudwatch:DescribeAlarmsForMetric",
                "cloudwatch:DescribeAlarmHistory",
                "cloudwatch:DescribeAlarms",
                "cloudwatch:ListMetrics",
                "cloudwatch:GetMetricData",
                "cloudwatch:GetInsightRuleReport",
                "cloudwatch:GetMetricStatistics"
            ],
            "Resource": "*"
        },
        {
            "Sid": "AllowReadingLogsFromCloudWatch",
            "Effect": "Allow",
            "Action": [
                "logs:DescribeLogGroups",
                "logs:GetLogGroupFields",
                "logs:StartQuery",
                "logs:StopQuery",
                "logs:GetQueryResults",
                "logs:GetLogEvents"
            ],
            "Resource": "*"
        },
        {
            "Sid": "AllowReadingTagsInstancesRegionsFromEC2",
            "Effect": "Allow",
            "Action": [
                "ec2:DescribeTags",
                "ec2:DescribeInstances",
                "ec2:DescribeRegions"
            ],
            "Resource": "*"
        },
        {
            "Sid": "AllowReadingResourcesForTags",
            "Effect": "Allow",
            "Action": "tag:GetResources",
            "Resource": "*"
        }
    ]
}
EOT
}

# Policy Attachment with Role
resource "aws_iam_role_policy_attachment" "prometheus_cloudwatch_exporter_policy" {
  # count      = var.secret_manifest == [] && try(var.prometheus_cloudwatch_exporter_extra_configs.role_name, "") != "" ? 1 : 0
  count      = var.secret_manifest == [] ? 1 : 0
  policy_arn = aws_iam_policy.policy[0].arn
  role       = aws_iam_role.role[0].name
}