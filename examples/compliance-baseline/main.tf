locals {
  name = var.eks_cluster_name
}

module "addons" {
  source = "../../"

  eks_cluster_name = local.name

  # Evidence and controls-oriented baseline
  metrics_server               = true
  cluster_autoscaler           = true
  aws_load_balancer_controller = true
  aws_node_termination_handler = true
  aws_ebs_csi_driver           = true
  aws_efs_csi_driver           = true
  calico_tigera                = true
  ingress_nginx                = true
  external_secrets             = true
  certification_manager        = true
  fluent_bit                   = true
  kube_state_metrics           = true
  prometheus                   = true
  reloader                     = true

  velero = true
  velero_extra_configs = {
    bucket_name = var.velero_bucket_name
  }
}
