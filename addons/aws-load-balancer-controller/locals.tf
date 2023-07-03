locals {
  name       = "aws-load-balancer-controller"

  # https://github.com/kubernetes-sigs/metrics-server/blob/master/charts/metrics-server/Chart.yaml
  default_helm_config = {
    name        = local.name
    chart       = local.name
    repository  = "https://aws.github.io/eks-charts"
    version     = "1.5.3"
    namespace   = "kube-system"
    description = "AWS Load Balancer Controller helm Chart deployment configuration"

    set_values = [
      {
        name  = "clusterName"
        value = data.aws_eks_cluster.eks_cluster.name
      },
      {
        name  = "controller.serviceAccount.create"
        value = "true"
      },
      {
        name  = "controller.serviceAccount.name"
        value = "${local.name}-sa"
      },
      {
        name  = "controller.serviceAccount.annotations.eks\\.amazonaws\\.com/role-arn"
        value = aws_iam_role.aws_load_balancer_controller.arn
      },
      {
        # Using the same service account for both the nodes and controllers,
        # and already creating the service account in the controller config
        # above.
        name = "node.serviceAccount.create"
        value = "false"
      },
      {
        name  = "node.serviceAccount.name"
        value = "${local.name}-sa"
      },
      {
        name  = "node.serviceAccount.annotations.eks\\.amazonaws\\.com/role-arn"
        value = aws_iam_role.aws_load_balancer_controller.arn
      }
    ]     
  }

  helm_config = merge(
    local.default_helm_config,
    var.helm_config
  )

  argocd_gitops_config = {
    enable = true
  }
}
