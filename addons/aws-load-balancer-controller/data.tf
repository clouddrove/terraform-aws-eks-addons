data "aws_eks_cluster" "eks_cluster" {
  # this makes downstream resources wait for data plane to be ready
  name = var.eks_cluster_name
}


# -- aws-load-balancer-controller
data "aws_iam_policy_document" "aws_load_balancer_controller_assume" {

  statement {
    actions = ["sts:AssumeRoleWithWebIdentity"]

    principals {
      type        = "Federated"
      identifiers = [replace("${data.aws_eks_cluster.eks_cluster.identity[0].oidc[0].issuer}", "https://", "")]
    }

    condition {
      test     = "StringEquals"
      variable = "${replace(data.aws_eks_cluster.eks_cluster.identity[0].oidc[0].issuer, "https://", "")}:sub"

      values = [
        "system:serviceaccount:kube-system:${local.name}-sa",
      ]
    }

    effect = "Allow"
  }
}

resource "aws_iam_role" "aws_load_balancer_controller" {
  name               = "${var.eks_cluster_name}-aws-load-balancer-controller"
  assume_role_policy = data.aws_iam_policy_document.aws_load_balancer_controller_assume.json
}

# service-account
resource "aws_iam_policy" "aws_load_balancer_controller" {
  depends_on = [
    var.eks_cluster_id,
  ]
  name        = "AWS_Load_Balancer_Controller_IAM_Policy"
  path        = "/"
  description = "Policy for the AWS Load Balancer Controller"

  policy = file("../../addons/aws-load-balancer-controller/policy.json")
}

resource "aws_iam_role_policy_attachment" "aws_load_balancer_controller" {
  role       = aws_iam_role.aws_load_balancer_controller.name
  policy_arn = aws_iam_policy.aws_load_balancer_controller.arn
}