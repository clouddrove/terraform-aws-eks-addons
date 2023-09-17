module "metrics_server" {
  count                        = var.metrics_server ? 1 : 0
  source                       = "./addons/metrics-server"
  helm_config                  = var.metrics_server_helm_config != null ? var.metrics_server_helm_config : { values = [local_file.metrics_server_helm_config[count.index].content] }
  manage_via_gitops            = var.manage_via_gitops
  addon_context                = local.addon_context
  metrics_server_extra_configs = var.metrics_server_extra_configs
}

module "cluster_autoscaler" {
  count                            = var.cluster_autoscaler ? 1 : 0
  source                           = "./addons/cluster-autoscaler"
  helm_config                      = var.cluster_autoscaler_helm_config != null ? var.cluster_autoscaler_helm_config : { values = [local_file.cluster_autoscaler_helm_config[count.index].content] }
  manage_via_gitops                = var.manage_via_gitops
  addon_context                    = local.addon_context
  eks_cluster_name                 = data.aws_eks_cluster.eks_cluster.name
  account_id                       = data.aws_caller_identity.current.account_id
  cluster_autoscaler_extra_configs = var.cluster_autoscaler_extra_configs
  iampolicy_json_content           = var.cluster_autoscaler_iampolicy_json_content
}

module "aws_load_balancer_controller" {
  count                                      = var.aws_load_balancer_controller ? 1 : 0
  source                                     = "./addons/aws-load-balancer-controller"
  helm_config                                = var.aws_load_balancer_controller_helm_config != null ? var.aws_load_balancer_controller_helm_config : { values = [local_file.aws_load_balancer_controller_helm_config[count.index].content] }
  manage_via_gitops                          = var.manage_via_gitops
  addon_context                              = local.addon_context
  eks_cluster_name                           = data.aws_eks_cluster.eks_cluster.name
  account_id                                 = data.aws_caller_identity.current.account_id
  aws_load_balancer_controller_extra_configs = var.aws_load_balancer_controller_extra_configs
  iampolicy_json_content                     = var.aws_load_balancer_controller_iampolicy_json_content
}

module "aws_node_termination_handler" {
  count                                      = var.aws_node_termination_handler ? 1 : 0
  source                                     = "./addons/aws-node-termination-handler"
  helm_config                                = var.aws_node_termination_handler_helm_config != null ? var.aws_node_termination_handler_helm_config : { values = [local_file.aws_node_termination_handler_helm_config[count.index].content] }
  manage_via_gitops                          = var.manage_via_gitops
  addon_context                              = local.addon_context
  aws_node_termination_handler_extra_configs = var.aws_node_termination_handler_extra_configs
}

module "aws_efs_csi_driver" {
  count                            = var.aws_efs_csi_driver ? 1 : 0
  source                           = "./addons/aws-efs-csi-driver"
  helm_config                      = var.aws_efs_csi_driver_helm_config != null ? var.aws_efs_csi_driver_helm_config : { values = [local_file.aws_efs_csi_driver_helm_config[count.index].content] }
  manage_via_gitops                = var.manage_via_gitops
  addon_context                    = local.addon_context
  eks_cluster_name                 = data.aws_eks_cluster.eks_cluster.name
  account_id                       = data.aws_caller_identity.current.account_id
  aws_efs_csi_driver_extra_configs = var.aws_efs_csi_driver_extra_configs
  iampolicy_json_content           = var.aws_efs_csi_driver_iampolicy_json_content
}

module "aws_ebs_csi_driver" {
  count                            = var.aws_ebs_csi_driver ? 1 : 0
  source                           = "./addons/aws-ebs-csi-driver"
  helm_config                      = var.aws_ebs_csi_driver_helm_config != null ? var.aws_ebs_csi_driver_helm_config : { values = [local_file.aws_ebs_csi_driver_helm_config[count.index].content] }
  manage_via_gitops                = var.manage_via_gitops
  addon_context                    = local.addon_context
  eks_cluster_name                 = data.aws_eks_cluster.eks_cluster.name
  account_id                       = data.aws_caller_identity.current.account_id
  aws_ebs_csi_driver_extra_configs = var.aws_ebs_csi_driver_extra_configs
  iampolicy_json_content           = var.aws_ebs_csi_driver_iampolicy_json_content
}

module "karpenter" {
  count                   = var.karpenter ? 1 : 0
  source                  = "./addons/karpenter"
  helm_config             = var.karpenter_helm_config != null ? var.karpenter_helm_config : { values = [local_file.karpenter_helm_config[count.index].content] }
  manage_via_gitops       = var.manage_via_gitops
  addon_context           = local.addon_context
  eks_cluster_name        = data.aws_eks_cluster.eks_cluster.name
  account_id              = data.aws_caller_identity.current.account_id
  karpenter_extra_configs = var.karpenter_extra_configs
  iampolicy_json_content  = var.karpenter_iampolicy_json_content
}

module "istio_ingress" {
  count                       = var.istio_ingress ? 1 : 0
  depends_on                  = [module.aws_load_balancer_controller]
  source                      = "./addons/istio-ingress"
  helm_config                 = var.istio_ingress_helm_config != null ? var.istio_ingress_helm_config : { values = [local_file.istio_ingress_helm_config[count.index].content] }
  manage_via_gitops           = var.manage_via_gitops
  addon_context               = local.addon_context
  istio_manifests             = var.istio_manifests
  istio_ingress_extra_configs = var.istio_ingress_extra_configs
}

module "kiali_server" {
  count                      = var.kiali_server && var.istio_ingress ? 1 : 0
  depends_on                 = [module.istio_ingress]
  source                     = "./addons/kiali-server"
  helm_config                = var.kiali_server_helm_config != null ? var.kiali_server_helm_config : { values = [local_file.kiali_server_helm_config[count.index].content] }
  manage_via_gitops          = var.manage_via_gitops
  addon_context              = local.addon_context
  kiali_manifests            = var.kiali_manifests
  kiali_server_extra_configs = var.kiali_server_extra_configs
}

module "calico_tigera" {
  count                       = var.calico_tigera ? 1 : 0
  source                      = "./addons/calico-tigera"
  helm_config                 = var.calico_tigera_helm_config != null ? var.calico_tigera_helm_config : { values = [local_file.calico_tigera_helm_config[count.index].content] }
  manage_via_gitops           = var.manage_via_gitops
  addon_context               = local.addon_context
  eks_cluster_name            = data.aws_eks_cluster.eks_cluster.name
  calico_tigera_extra_configs = var.calico_tigera_extra_configs
}

module "external_secrets" {
  count                          = var.external_secrets ? 1 : 0
  source                         = "./addons/external-secrets"
  helm_config                    = var.external_secrets_helm_config != null ? var.external_secrets_helm_config : { values = [local_file.external_secrets_helm_config[count.index].content] }
  manage_via_gitops              = var.manage_via_gitops
  addon_context                  = local.addon_context
  eks_cluster_name               = data.aws_eks_cluster.eks_cluster.name
  account_id                     = data.aws_caller_identity.current.account_id
  externalsecrets_manifests      = var.externalsecrets_manifests
  external_secrets_extra_configs = var.external_secrets_extra_configs
}

module "ingress_nginx" {
  count                       = var.ingress_nginx ? 1 : 0
  source                      = "./addons/ingress-nginx"
  helm_config                 = var.ingress_nginx_helm_config != null ? var.ingress_nginx_helm_config : { values = [local_file.ingress_nginx_helm_config[count.index].content] }
  manage_via_gitops           = var.manage_via_gitops
  addon_context               = local.addon_context
  ingress_nginx_extra_configs = var.ingress_nginx_extra_configs
}

module "kubeclarity" {
  count                     = var.kubeclarity ? 1 : 0
  source                    = "./addons/kubeclarity"
  helm_config               = var.kubeclarity_helm_config != null ? var.kubeclarity_helm_config : { values = [local_file.kubeclarity_helm_config[count.index].content] }
  manage_via_gitops         = var.manage_via_gitops
  addon_context             = local.addon_context
  kubeclarity_extra_configs = var.kubeclarity_extra_configs
}

module "fluent_bit" {
  count                    = var.fluent_bit ? 1 : 0
  source                   = "./addons/fluent-bit"
  helm_config              = var.fluent_bit_helm_config != null ? var.fluent_bit_helm_config : { values = [local_file.fluent_bit_helm_config[count.index].content] }
  manage_via_gitops        = var.manage_via_gitops
  addon_context            = local.addon_context
  eks_cluster_name         = data.aws_eks_cluster.eks_cluster.name
  account_id               = data.aws_caller_identity.current.account_id
  fluent_bit_extra_configs = var.fluent_bit_extra_configs
  iampolicy_json_content   = var.fluent_bit_iampolicy_json_content
}
module "new_relic" {
  count                   = var.new_relic ? 1 : 0
  source                  = "./addons/nri-bundle"
  helm_config             = var.new_relic_helm_config != null ? var.new_relic_helm_config : { values = [local_file.new_relic_helm_config[count.index].content] }
  manage_via_gitops       = var.manage_via_gitops
  addon_context           = local.addon_context
  eks_cluster_name        = data.aws_eks_cluster.eks_cluster.name
  new_relic_extra_configs = var.new_relic_extra_configs
}