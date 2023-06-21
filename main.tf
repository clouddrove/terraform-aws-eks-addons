module "k8s_addons" {
  depends_on     = [module.service_monitor_crd]
  source         = "./addons/helm"
  eks_cluster_id = var.eks_cluster_name

  #metrics server
  enable_metrics_server = var.metrics_server_enabled
  metrics_server_helm_config = {
    version = var.metrics_server_helm_version
    values  = [file("${path.module}/addons/metrics_server/metrics_server.yaml")]
  }
}
