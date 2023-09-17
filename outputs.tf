#----------- METRIC SERVER ---------------------
output "metrics_server_namespace" {
  value = module.metrics_server[*].namespace
}
output "metrics_server_chart_version" {
  value = module.metrics_server[*].chart_version
}
output "metrics_server_repository" {
  value = module.metrics_server[*].repository
}

#----------- CLUSTER AUTOSCALER ----------------
output "cluster_autoscaler_service_account" {
  value = module.cluster_autoscaler[*].service_account
}
output "cluster_autoscaler_iam_policy" {
  value = module.cluster_autoscaler[*].iam_policy
}
output "cluster_autoscaler_namespace" {
  value = module.cluster_autoscaler[*].namespace
}
output "cluster_autoscaler_chart_version" {
  value = module.cluster_autoscaler[*].chart_version
}
output "cluster_autoscaler_repository" {
  value = module.cluster_autoscaler[*].repository
}

#----------- AWS EFS CSI DRIVER ----------------
output "aws_efs_csi_driver_service_account" {
  value = module.aws_efs_csi_driver[*].service_account
}
output "aws_efs_csi_driver_iam_policy" {
  value = module.aws_efs_csi_driver[*].iam_policy
}
output "aws_efs_csi_driver_namespace" {
  value = module.aws_efs_csi_driver[*].namespace
}
output "aws_efs_csi_driver_chart_version" {
  value = module.aws_efs_csi_driver[*].chart_version
}
output "aws_efs_csi_driver_repository" {
  value = module.aws_efs_csi_driver[*].repository
}

#----------- AWS EBS CSI DRIVER ----------------
output "aws_ebs_csi_driver_service_account" {
  value = module.aws_ebs_csi_driver[*].service_account
}
output "aws_ebs_csi_driver_iam_policy" {
  value = module.aws_ebs_csi_driver[*].iam_policy
}
output "aws_ebs_csi_driver_namespace" {
  value = module.aws_ebs_csi_driver[*].namespace
}
output "aws_ebs_csi_driver_chart_version" {
  value = module.aws_ebs_csi_driver[*].chart_version
}
output "aws_ebs_csi_driver_repository" {
  value = module.aws_ebs_csi_driver[*].repository
}

#----------- KARPENTER -------------------------
output "karpenter_service_account" {
  value = module.karpenter[*].service_account
}
output "karpenter_iam_policy" {
  value = module.karpenter[*].iam_policy
}
output "karpenter_namespace" {
  value = module.karpenter[*].namespace
}
output "karpenter_chart_version" {
  value = module.karpenter[*].chart_version
}
output "karpenter_repository" {
  value = module.karpenter[*].repository
}

#----------- ISTIO INGRESS ---------------------
output "istio_ingress_namespace" {
  value = module.istio_ingress[*].namespace
}
output "istio_ingress_chart_version" {
  value = module.istio_ingress[*].chart_version
}
output "istio_ingress_repository" {
  value = module.istio_ingress[*].repository
}

#----------- KAILI DASHBOARD -------------------
output "kiali_server_namespace" {
  value = module.kiali_server[*].namespace
}
output "kiali_server_chart_version" {
  value = module.kiali_server[*].chart_version
}
output "kiali_server_repository" {
  value = module.kiali_server[*].repository
}

#----------- CALICO TOGERA ---------------------
output "calico_tigera_namespace" {
  value = module.calico_tigera[*].namespace
}
output "calico_tigera_chart_version" {
  value = module.calico_tigera[*].chart_version
}
output "calico_tigera_repository" {
  value = module.calico_tigera[*].repository
}

#----------- EXTERNAL SECRETS ------------------
output "external_secrets_secret_manager_name" {
  value = module.external_secrets[*].secret_manager_name
}
output "external_secrets_service_account" {
  value = module.external_secrets[*].service_account
}
output "external_secrets_namespace" {
  value = module.external_secrets[*].namespace
}
output "external_secrets_chart_version" {
  value = module.ingress_nginx[*].chart_version
}
output "external_secrets_repository" {
  value = module.ingress_nginx[*].repository
}

#----------- INGRESS NGINX ---------------------
output "ingress_nginx_namespace" {
  value = module.ingress_nginx[*].namespace
}
output "ingress_nginx_chart_version" {
  value = module.ingress_nginx[*].chart_version
}
output "ingress_nginx_repository" {
  value = module.ingress_nginx[*].repository
}

#----------- KUBECLARITY -----------------------
output "kubeclarity_namespace" {
  value = module.kubeclarity[*].namespace
}
output "kubeclarity_chart_version" {
  value = module.kubeclarity[*].chart_version
}
output "kubeclarity_repository" {
  value = module.kubeclarity[*].repository
}

#----------- AWS LOAD BALANCER CONTROLLER ----------------
output "aws_load_balancer_controller_service_account" {
  value = module.aws_load_balancer_controller[*].service_account
}
output "aws_load_balancer_controller_iam_policy" {
  value = module.aws_load_balancer_controller[*].iam_policy
}
output "aws_load_balancer_controller_namespace" {
  value = module.aws_load_balancer_controller[*].namespace
}
output "aws_load_balancer_controller_chart_version" {
  value = module.aws_load_balancer_controller[*].chart_version
}
output "aws_load_balancer_controller_repository" {
  value = module.aws_load_balancer_controller[*].repository
}

#----------- FLUENT-BIT ----------------
output "fluent_bit_service_account" {
  value = module.fluent_bit[*].service_account
}
output "fluent_bit_iam_policy" {
  value = module.fluent_bit[*].iam_policy
}
output "fluent_bit_namespace" {
  value = module.fluent_bit[*].namespace
}
output "fluent_bit_chart_version" {
  value = module.fluent_bit[*].chart_version
}
output "fluent_bit_repository" {
  value = module.fluent_bit[*].repository
}

#----------- NEW-RELIC ------------------------
output "new_relic_namespace" {
  value = module.new_relic[*].namespace
}
output "new_relic_chart_version" {
  value = module.new_relic[*].chart_version
}
output "new_relic_repository" {
  value = module.new_relic[*].repository
}