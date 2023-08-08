module "metrics_server" {
  count             = var.metrics_server ? 1 : 0
  source            = "./addons/metrics-server"
  helm_config       = var.metrics_server_helm_config != null ? var.metrics_server_helm_config : { values = ["${local_file.metrics_server_helm_config[0].content}"] }
  manage_via_gitops = var.manage_via_gitops
  addon_context     = local.addon_context
}

module "cluster_autoscaler" {
  count             = var.cluster_autoscaler ? 1 : 0
  source            = "./addons/cluster-autoscaler"
  helm_config       = var.cluster_autoscaler_helm_config != null ? var.cluster_autoscaler_helm_config : { values = ["${local_file.cluster_autoscaler_helm_config[0].content}"] }
  manage_via_gitops = var.manage_via_gitops
  addon_context     = local.addon_context
  eks_cluster_name  = data.aws_eks_cluster.eks_cluster.name
  account_id        = data.aws_caller_identity.current.account_id
}

module "aws_load_balancer_controller" {
  count             = var.aws_load_balancer_controller ? 1 : 0
  source            = "./addons/aws-load-balancer-controller"
  helm_config       = var.aws_load_balancer_controller_helm_config != null ? var.aws_load_balancer_controller_helm_config : { values = ["${local_file.aws_load_balancer_controller_helm_config[0].content}"] }
  manage_via_gitops = var.manage_via_gitops
  addon_context     = local.addon_context
  eks_cluster_name  = data.aws_eks_cluster.eks_cluster.name
  account_id        = data.aws_caller_identity.current.account_id
}

module "aws_node_termination_handler" {
  count             = var.aws_node_termination_handler ? 1 : 0
  source            = "./addons/aws-node-termination-handler"
  helm_config       = var.aws_node_termination_handler_helm_config != null ? var.aws_node_termination_handler_helm_config : { values = ["${local_file.aws_node_termination_handler_helm_config[0].content}"] }
  manage_via_gitops = var.manage_via_gitops
  addon_context     = local.addon_context
}

module "aws_efs_csi_driver" {
  count             = var.aws_efs_csi_driver ? 1 : 0
  source            = "./addons/aws-efs-csi-driver"
  helm_config       = var.aws_efs_csi_driver_helm_config != null ? var.aws_efs_csi_driver_helm_config : { values = ["${local_file.aws_efs_csi_driver_helm_config[0].content}"] }
  manage_via_gitops = var.manage_via_gitops
  addon_context     = local.addon_context
  eks_cluster_name  = data.aws_eks_cluster.eks_cluster.name
  account_id        = data.aws_caller_identity.current.account_id
}

module "aws_ebs_csi_driver" {
  count             = var.aws_ebs_csi_driver ? 1 : 0
  source            = "./addons/aws-ebs-csi-driver"
  helm_config       = var.aws_ebs_csi_driver_helm_config != null ? var.aws_ebs_csi_driver_helm_config : { values = ["${local_file.aws_ebs_csi_driver_helm_config[0].content}"] }
  manage_via_gitops = var.manage_via_gitops
  addon_context     = local.addon_context
  eks_cluster_name  = data.aws_eks_cluster.eks_cluster.name
  account_id        = data.aws_caller_identity.current.account_id
}

module "karpenter" {
  count             = var.karpenter ? 1 : 0
  source            = "./addons/karpenter"
  helm_config       = var.karpenter_helm_config != null ? var.karpenter_helm_config : { values = ["${local_file.karpenter_helm_config[0].content}"] }
  manage_via_gitops = var.manage_via_gitops
  addon_context     = local.addon_context
  eks_cluster_name  = data.aws_eks_cluster.eks_cluster.name
  account_id        = data.aws_caller_identity.current.account_id
}

module "istio_ingress" {
  count             = var.istio_ingress ? 1 : 0
  depends_on        = [module.aws_load_balancer_controller]
  source            = "./addons/istio-ingress"
  helm_config       = var.istio_ingress_helm_config != null ? var.istio_ingress_helm_config : { values = ["${local_file.istio_ingress_helm_config[0].content}"] }
  manage_via_gitops = var.manage_via_gitops
  addon_context     = local.addon_context
  eks_cluster_name  = data.aws_eks_cluster.eks_cluster.name
  istio_manifests   = var.istio_manifests
}

module "kiali_server" {
  count             = var.kiali_server ? 1 : 0
  depends_on        = [module.istio_ingress]
  source            = "./addons/kiali-server"
  helm_config       = var.kiali_server_helm_config != null ? var.kiali_server_helm_config : { values = ["${local_file.kiali_server_helm_config[0].content}"] }
  manage_via_gitops = var.manage_via_gitops
  addon_context     = local.addon_context
  kiali_manifests   = var.kiali_manifests
}

module "calico_tigera" {
  count             = var.calico_tigera ? 1 : 0
  source            = "./addons/calico-tigera"
  helm_config       = var.calico_tigera_helm_config != null ? var.calico_tigera_helm_config : { values = ["${local_file.calico_tigera_helm_config[0].content}"] }
  manage_via_gitops = var.manage_via_gitops
  addon_context     = local.addon_context
  eks_cluster_name  = data.aws_eks_cluster.eks_cluster.name
}

module "external_secrets" {
  count                     = var.external_secrets ? 1 : 0
  source                    = "./addons/external-secrets"
  helm_config               = var.external_secrets_helm_config != null ? var.external_secrets_helm_config : { values = ["${local_file.external_secrets_helm_config[0].content}"] }
  manage_via_gitops         = var.manage_via_gitops
  addon_context             = local.addon_context
  eks_cluster_name          = data.aws_eks_cluster.eks_cluster.name
  account_id                = data.aws_caller_identity.current.account_id
  externalsecrets_manifests = var.externalsecrets_manifests
}
