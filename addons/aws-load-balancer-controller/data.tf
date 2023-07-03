data "aws_eks_cluster" "eks_cluster" {
  # this makes downstream resources wait for data plane to be ready
  name = var.eks_cluster_name
}


# -- aws-load-balancer-controller
# Line-15 Should not be hardcoded with `oidc_provider`
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
        "system:serviceaccount:kube-system:aws-load-balancer-controller-sa",
      ]
    }

    effect = "Allow"
  }
}

resource "aws_iam_role" "aws_load_balancer_controller" {
  name               = "${var.eks_cluster_name}-aws-load-balancer-controller"
  assume_role_policy = data.aws_iam_policy_document.aws_load_balancer_controller_assume.json
}