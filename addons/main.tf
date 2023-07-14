module "metrics_server" {
  count             = var.metrics_server ? 1 : 0
  source            = "./metrics-server"
  helm_config       = var.metrics_server_helm_config != null ? var.metrics_server_helm_config : { values = ["${file("../../addons/metrics-server/config/metrics_server.yaml")}"] }
  manage_via_gitops = var.manage_via_gitops
  addon_context     = local.addon_context
}


module "cluster_autoscaler" {
  count             = var.cluster_autoscaler ? 1 : 0
  source            = "./cluster-autoscaler"
  helm_config       = var.cluster_autoscaler_helm_config != null ? var.cluster_autoscaler_helm_config : { values = ["${file("../../addons/cluster-autoscaler/config/cluster_autoscaler.yaml")}"] }
  manage_via_gitops = var.manage_via_gitops
  addon_context     = local.addon_context
  eks_cluster_name  = data.aws_eks_cluster.eks_cluster.name
  account_id        = data.aws_caller_identity.current.account_id
}

module "aws_load_balancer_controller" {
  count             = var.aws_load_balancer_controller ? 1 : 0
  source            = "./aws-load-balancer-controller"
  helm_config       = var.aws_load_balancer_controller_helm_config != null ? var.aws_load_balancer_controller_helm_config : { values = ["${file("../../addons/aws-load-balancer-controller/config/aws_load_balancer_controller.yaml")}"] }
  manage_via_gitops = var.manage_via_gitops
  addon_context     = local.addon_context
  eks_cluster_name  = data.aws_eks_cluster.eks_cluster.name
  account_id        = data.aws_caller_identity.current.account_id
}

module "aws_node_termination_handler" {
  count             = var.aws_node_termination_handler ? 1 : 0
  source            = "./aws-node-termination-handler"
  helm_config       = var.aws_node_termination_handler_helm_config != null ? var.aws_node_termination_handler_helm_config : { values = ["${file("../../addons/aws-node-termination-handler/config/aws_node_termination_handler.yaml")}"] }
  manage_via_gitops = var.manage_via_gitops
  addon_context     = local.addon_context
}

module "aws_efs_csi_driver" {
  count             = var.aws_efs_csi_driver ? 1 : 0
  source            = "./aws-efs-csi-driver"
  helm_config       = var.aws_efs_csi_driver_helm_config != null ? var.aws_efs_csi_driver_helm_config : { values = ["${file("../../addons/aws-efs-csi-driver/config/aws_efs_csi_driver.yaml")}"] }
  manage_via_gitops = var.manage_via_gitops
  addon_context     = local.addon_context
  eks_cluster_name  = data.aws_eks_cluster.eks_cluster.name
  account_id        = data.aws_caller_identity.current.account_id
}

module "aws_ebs_csi_driver" {
  count             = var.aws_ebs_csi_driver ? 1 : 0
  source            = "./aws-ebs-csi-driver"
  helm_config       = var.aws_ebs_csi_driver_helm_config != null ? var.aws_ebs_csi_driver_helm_config : { values = ["${file("../../addons/aws-ebs-csi-driver/config/aws_ebs_csi_driver.yaml")}"] }
  manage_via_gitops = var.manage_via_gitops
  addon_context     = local.addon_context
  eks_cluster_name  = data.aws_eks_cluster.eks_cluster.name
  account_id        = data.aws_caller_identity.current.account_id
}

module "karpenter" {
  count             = var.karpenter ? 1 : 0
  source            = "./karpenter"
  helm_config       = var.karpenter_helm_config != null ? var.karpenter_helm_config : { values = ["${file("../../addons/karpenter/config/karpenter.yaml")}"] }
  manage_via_gitops = var.manage_via_gitops
  addon_context     = local.addon_context
  eks_cluster_name  = data.aws_eks_cluster.eks_cluster.name
  account_id        = data.aws_caller_identity.current.account_id
}

module "istio_ingress" {
  count             = var.istio_ingress ? 1 : 0
  depends_on        = [module.aws_load_balancer_controller]
  source            = "./istio-ingress"
  helm_config       = var.istio_ingress_helm_config != null ? var.istio_ingress_helm_config : { values = ["${file("../../addons/istio-ingress/config/override-values.yaml")}"] }
  manage_via_gitops = var.manage_via_gitops
  addon_context     = local.addon_context
  eks_cluster_name  = data.aws_eks_cluster.eks_cluster.name
  istio_manifests   = var.istio_manifests
}