locals {
  name = var.eks_cluster_name
}

module "addons" {
  source = "../../"

  eks_cluster_name = local.name

  # Security-focused baseline
  metrics_server               = true
  cluster_autoscaler           = true
  aws_load_balancer_controller = true
  aws_node_termination_handler = true
  aws_efs_csi_driver           = true
  aws_ebs_csi_driver           = true
  calico_tigera                = true
  ingress_nginx                = true
  external_secrets             = true
  certification_manager        = true
  reloader                     = true
}
