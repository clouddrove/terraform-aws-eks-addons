module "metrics_server" {
  count             = var.enable_metrics_server ? 1 : 0
  source            = "./metrics-server"
  helm_config       = var.metrics_server_helm_config != null ? var.metrics_server_helm_config : { values = ["${file("../../addons/metrics-server/config/metrics_server.yaml")}"] }
  manage_via_gitops = var.manage_via_gitops
  addon_context     = local.addon_context
}

module "cluster_autoscaler" {
  count             = var.enable_cluster_autoscaler ? 1 : 0
  source            = "./cluster-autoscaler"
  helm_config       = var.cluster_autoscaler_helm_config != null ? var.cluster_autoscaler_helm_config : { values = ["${file("../../addons/cluster-autoscaler/config/cluster_autoscaler.yaml")}"] }
  manage_via_gitops = var.manage_via_gitops
  addon_context     = local.addon_context
  eks_cluster_name  = data.aws_eks_cluster.eks_cluster.name
  account_id        = data.aws_caller_identity.current.account_id
}

module "aws_load_balancer_controller" {
  count             = var.enable_aws_load_balancer_controller ? 1 : 0
  source            = "./aws-load-balancer-controller"
  helm_config       = var.aws_load_balancer_controller_helm_config != null ? var.aws_load_balancer_controller_helm_config : { values = ["${file("../../addons/aws-load-balancer-controller/config/aws_load_balancer_controller.yaml")}"] }
  manage_via_gitops = var.manage_via_gitops
  addon_context     = local.addon_context
  eks_cluster_name  = data.aws_eks_cluster.eks_cluster.name
  account_id        = data.aws_caller_identity.current.account_id
}
