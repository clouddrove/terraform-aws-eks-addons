locals {
  name = var.eks_cluster_name
}

module "addons" {
  source = "../../"

  eks_cluster_name = local.name

  # Cost-aware baseline (minimal but practical)
  metrics_server               = true
  cluster_autoscaler           = true
  aws_load_balancer_controller = true
  aws_node_termination_handler = true
  aws_ebs_csi_driver           = true
  ingress_nginx                = true
  keda                         = true
  external_dns                 = true
  reloader                     = true
}
