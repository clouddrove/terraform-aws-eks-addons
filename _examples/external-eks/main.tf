# ------------------------------------------------------------------------------
# Resources
# ------------------------------------------------------------------------------

locals {
  name   = "test-eks-cluster"
  region = "us-east-1"
}

module "addons" {
  source = "../../"

  eks_cluster_name = local.name

  # -- Enable Addons
  metrics_server                 = true
  cluster_autoscaler             = true
  aws_load_balancer_controller   = true
  aws_node_termination_handler   = true
  aws_efs_csi_driver             = true
  aws_ebs_csi_driver             = true
  kube_state_metrics             = true
  karpenter                      = false # -- Set to `false` or comment line to Uninstall Karpenter if installed using terraform.
  calico_tigera                  = true
  new_relic                      = true
  kubeclarity                    = true
  ingress_nginx                  = true
  fluent_bit                     = true
  velero                         = true
  keda                           = true
  certification_manager          = true
  filebeat                       = true
  reloader                       = true
  redis                          = true
  prometheus_cloudwatch_exporter = true

  # -- Addons with mandatory variable
  istio_ingress    = true
  istio_manifests  = var.istio_manifests
  kiali_server     = true
  kiali_manifests  = var.kiali_manifests
  external_secrets = true

  # -- Path of override-values.yaml file
  metrics_server_helm_config                     = { values = [file("./config/override-metrics-server.yaml")] }
  cluster_autoscaler_helm_config                 = { values = [file("./config/override-cluster-autoscaler.yaml")] }
  karpenter_helm_config                          = { values = [file("./config/override-karpenter.yaml")] }
  aws_load_balancer_controller_helm_config       = { values = [file("./config/override-aws-load-balancer-controller.yaml")] }
  aws_node_termination_handler_helm_config       = { values = [file("./config/override-aws-node-termination-handler.yaml")] }
  aws_efs_csi_driver_helm_config                 = { values = [file("./config/override-aws-efs-csi-driver.yaml")] }
  aws_ebs_csi_driver_helm_config                 = { values = [file("./config/override-aws-ebs-csi-driver.yaml")] }
  calico_tigera_helm_config                      = { values = [file("./config/calico-tigera-values.yaml")] }
  istio_ingress_helm_config                      = { values = [file("./config/istio/override-values.yaml")] }
  kiali_server_helm_config                       = { values = [file("./config/kiali/override-values.yaml")] }
  external_secrets_helm_config                   = { values = [file("./config/external-secret/override-values.yaml")] }
  ingress_nginx_helm_config                      = { values = [file("./config/override-ingress-nginx.yaml")] }
  kubeclarity_helm_config                        = { values = [file("./config/override-kubeclarity.yaml")] }
  fluent_bit_helm_config                         = { values = [file("./config/override-fluent-bit.yaml")] }
  velero_helm_config                             = { values = [file("./config/override-velero.yaml")] }
  new_relic_helm_config                          = { values = [file("./config/override-new-relic.yaml")] }
  kube_state_metrics_helm_config                 = { values = [file("./config/override-kube-state-matrics.yaml")] }
  keda_helm_config                               = { values = [file("./config/keda/override-keda.yaml")] }
  certification_manager_helm_config              = { values = [file("./config/override-certification-manager.yaml")] }
  filebeat_helm_config                           = { values = [file("./config/override-filebeat.yaml")] }
  reloader_helm_config                           = { values = [file("./config/reloader/override-reloader.yaml")] }
  redis_helm_config                              = { values = [file("./config/override-redis.yaml")] }
  prometheus_cloudwatch_exporter_helm_config     = { values = [file("./config/prometheus-cloudwatch-exporter/override-prometheus-cloudwatch-exporter-controller.yaml")] }
  prometheus_cloudwatch_exporter_secret_manifest = ["./config/prometheus-cloudwatch-exporter/secret.yaml"]

  # -- Override Helm Release attributes
  metrics_server_extra_configs                 = var.metrics_server_extra_configs
  cluster_autoscaler_extra_configs             = var.cluster_autoscaler_extra_configs
  karpenter_extra_configs                      = var.karpenter_extra_configs
  aws_load_balancer_controller_extra_configs   = var.aws_load_balancer_controller_extra_configs
  aws_node_termination_handler_extra_configs   = var.aws_node_termination_handler_extra_configs
  aws_efs_csi_driver_extra_configs             = var.aws_efs_csi_driver_extra_configs
  aws_ebs_csi_driver_extra_configs             = var.aws_ebs_csi_driver_extra_configs
  calico_tigera_extra_configs                  = var.calico_tigera_extra_configs
  istio_ingress_extra_configs                  = var.istio_ingress_extra_configs
  kiali_server_extra_configs                   = var.kiali_server_extra_configs
  ingress_nginx_extra_configs                  = var.ingress_nginx_extra_configs
  kubeclarity_extra_configs                    = var.kubeclarity_extra_configs
  fluent_bit_extra_configs                     = var.fluent_bit_extra_configs
  velero_extra_configs                         = var.velero_extra_configs
  new_relic_extra_configs                      = var.new_relic_extra_configs
  kube_state_metrics_extra_configs             = var.kube_state_metrics_extra_configs
  keda_extra_configs                           = var.keda_extra_configs
  certification_manager_extra_configs          = var.certification_manager_extra_configs
  external_secrets_extra_configs               = var.external_secrets_extra_configs
  filebeat_extra_configs                       = var.filebeat_extra_configs
  reloader_extra_configs                       = var.reloader_extra_configs
  redis_extra_configs                          = var.redis_extra_configs
  prometheus_cloudwatch_exporter_extra_configs = var.prometheus_cloudwatch_exporter_extra_configs

  # -- Custom IAM Policy Json for Addon's ServiceAccount
  external_secrets_iampolicy_json_content = file("./custom-iam-policies/external-secrets.json")
}
