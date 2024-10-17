#----------- METRIC SERVER ---------------------
output "metrics_server_namespace" {
  value       = module.metrics_server[*].namespace
  description = "Namespace where metrics-server is installed"
}
output "metrics_server_chart_version" {
  value       = module.metrics_server[*].chart_version
  description = "chart version used for metrics-server helmchart"
}
output "metrics_server_repository" {
  value       = module.metrics_server[*].repository
  description = "helm repository url of metrics-server"
}

#----------- CLUSTER AUTOSCALER ----------------
output "cluster_autoscaler_service_account" {
  value       = module.cluster_autoscaler[*].service_account
  description = "name of cluster-autoscaler service-account"
}
output "cluster_autoscaler_iam_policy" {
  value       = module.cluster_autoscaler[*].iam_policy
  description = "IAM Policy name used in cluster-autoscaler irsa"
}
output "cluster_autoscaler_namespace" {
  value       = module.cluster_autoscaler[*].namespace
  description = "Namespace where cluster-autoscaler is installed"
}
output "cluster_autoscaler_chart_version" {
  value       = module.cluster_autoscaler[*].chart_version
  description = "chart version used for cluster-autoscaler helmchart"
}
output "cluster_autoscaler_repository" {
  value       = module.cluster_autoscaler[*].repository
  description = "helm repository url of cluster-autoscaler"
}

#----------- AWS EFS CSI DRIVER ----------------
output "aws_efs_csi_driver_service_account" {
  value       = module.aws_efs_csi_driver[*].service_account
  description = "name of aws-efs-csi-driver service-account"
}
output "aws_efs_csi_driver_iam_policy" {
  value       = module.aws_efs_csi_driver[*].iam_policy
  description = "IAM Policy name used in aws-efs-csi-driver irsa"
}
output "aws_efs_csi_driver_namespace" {
  value       = module.aws_efs_csi_driver[*].namespace
  description = "Namespace where aws-efs-csi-driver is installed"
}
output "aws_efs_csi_driver_chart_version" {
  value       = module.aws_efs_csi_driver[*].chart_version
  description = "chart version used for aws-efs-csi-driver helmchart"
}
output "aws_efs_csi_driver_repository" {
  value       = module.aws_efs_csi_driver[*].repository
  description = "helm repository url of aws-efs-csi-driver"
}

#----------- AWS EBS CSI DRIVER ----------------
output "aws_ebs_csi_driver_service_account" {
  value       = module.aws_ebs_csi_driver[*].service_account
  description = "name of aws-ebs-csi-driver service-account"
}
output "aws_ebs_csi_driver_iam_policy" {
  value       = module.aws_ebs_csi_driver[*].iam_policy
  description = "IAM Policy name used in aws-ebs-csi-driver irsa"
}
output "aws_ebs_csi_driver_namespace" {
  value       = module.aws_ebs_csi_driver[*].namespace
  description = "Namespace where aws-ebs-csi-driver is installed"
}
output "aws_ebs_csi_driver_chart_version" {
  value       = module.aws_ebs_csi_driver[*].chart_version
  description = "chart version used for aws-ebs-csi-driver helmchart"
}
output "aws_ebs_csi_driver_repository" {
  value       = module.aws_ebs_csi_driver[*].repository
  description = "helm repository url of aws-ebs-csi-driver"
}

#----------- KARPENTER -------------------------
output "karpenter_service_account" {
  value       = module.karpenter[*].service_account
  description = "name of karpenter service-account"
}
output "karpenter_iam_policy" {
  value       = module.karpenter[*].iam_policy
  description = "IAM Policy name used in karpenter irsa"
}
output "karpenter_namespace" {
  value       = module.karpenter[*].namespace
  description = "Namespace where karpenter is installed"
}
output "karpenter_chart_version" {
  value       = module.karpenter[*].chart_version
  description = "chart version used for karpenter helmchart"
}
output "karpenter_repository" {
  value       = module.karpenter[*].repository
  description = "helm repository url of karpenter"
}

#----------- ISTIO INGRESS ---------------------
output "istio_ingress_namespace" {
  value       = module.istio_ingress[*].namespace
  description = "Namespace where istio-ingress is installed"
}
output "istio_ingress_chart_version" {
  value       = module.istio_ingress[*].chart_version
  description = "chart version used for istio-ingress helmchart"
}
output "istio_ingress_repository" {
  value       = module.istio_ingress[*].repository
  description = "helm repository url of istio-ingress"
}

#----------- KAILI DASHBOARD -------------------
output "kiali_server_namespace" {
  value       = module.kiali_server[*].namespace
  description = "Namespace where kiali-server is installed"
}
output "kiali_server_chart_version" {
  value       = module.kiali_server[*].chart_version
  description = "chart version used for kiali-server helmchart"
}
output "kiali_server_repository" {
  value       = module.kiali_server[*].repository
  description = "helm repository url of kiali-server"
}

#----------- CALICO TOGERA ---------------------
output "calico_tigera_namespace" {
  value       = module.calico_tigera[*].namespace
  description = "Namespace where calico-tigera is installed"
}
output "calico_tigera_chart_version" {
  value       = module.calico_tigera[*].chart_version
  description = "chart version used for calico-tigera helmchart"
}
output "calico_tigera_repository" {
  value       = module.calico_tigera[*].repository
  description = "helm repository url of calico-tigera"
}

#----------- EXTERNAL SECRETS ------------------
output "external_secrets_service_account" {
  value       = module.external_secrets[*].service_account
  description = "name of external-secrets service-account"
}
output "external_secrets_namespace" {
  value       = module.external_secrets[*].namespace
  description = "Namespace where external-secrets is installed"
}
output "external_secrets_chart_version" {
  value       = module.ingress_nginx[*].chart_version
  description = "chart version used for external-secrets helmchart"
}
output "external_secrets_repository" {
  value       = module.ingress_nginx[*].repository
  description = "helm repository url of external-secrets"
}
output "external_secrets_iam_policy" {
  value       = module.external_secrets[*].iam_policy
  description = "Name of IAM Policy used in external-secrets irsa"
}

#----------- INGRESS NGINX ---------------------
output "ingress_nginx_namespace" {
  value       = module.ingress_nginx[*].namespace
  description = "Namespace where ingress-nginx is installed"
}
output "ingress_nginx_chart_version" {
  value       = module.ingress_nginx[*].chart_version
  description = "chart version used for ingress-nginx helmchart"
}
output "ingress_nginx_repository" {
  value       = module.ingress_nginx[*].repository
  description = "helm repository url of ingress-nginx"
}

#----------- KUBECLARITY -----------------------
output "kubeclarity_namespace" {
  value       = module.kubeclarity[*].namespace
  description = "Namespace where kubeclarity is installed"
}
output "kubeclarity_chart_version" {
  value       = module.kubeclarity[*].chart_version
  description = "chart version used for kubeclarity helmchart"
}
output "kubeclarity_repository" {
  value       = module.kubeclarity[*].repository
  description = "helm repository url of kubeclarity"
}

#----------- AWS LOAD BALANCER CONTROLLER ----------------
output "aws_load_balancer_controller_service_account" {
  value       = module.aws_load_balancer_controller[*].service_account
  description = "name of aws-load-balancer-controller service-account"
}
output "aws_load_balancer_controller_iam_policy" {
  value       = module.aws_load_balancer_controller[*].iam_policy
  description = "IAM Policy name used in aws-load-balancer-controller irsa"
}
output "aws_load_balancer_controller_namespace" {
  value       = module.aws_load_balancer_controller[*].namespace
  description = "Namespace where aws-load-balancer-controller is installed"
}
output "aws_load_balancer_controller_chart_version" {
  value       = module.aws_load_balancer_controller[*].chart_version
  description = "chart version used for aws-load-balancer-controller helmchart"
}
output "aws_load_balancer_controller_repository" {
  value       = module.aws_load_balancer_controller[*].repository
  description = "helm repository url of aws-load-balancer-controller"
}

#----------- FLUENT-BIT ----------------
output "fluent_bit_service_account" {
  value       = module.fluent_bit[*].service_account
  description = "name of fluent-bit service-account"
}
output "fluent_bit_iam_policy" {
  value       = module.fluent_bit[*].iam_policy
  description = "IAM Policy name used in fluent-bit irsa"
}
output "fluent_bit_namespace" {
  value       = module.fluent_bit[*].namespace
  description = "Namespace where fluent-bit is installed"
}
output "fluent_bit_chart_version" {
  value       = module.fluent_bit[*].chart_version
  description = "chart version used for fluent-bit helmchart"
}
output "fluent_bit_repository" {
  value       = module.fluent_bit[*].repository
  description = "helm repository url of fluent-bit"
}

#----------- NEW-RELIC ------------------------
output "new_relic_namespace" {
  value       = module.new_relic[*].namespace
  description = "Namespace where new-relic is installed"
}
output "new_relic_chart_version" {
  value       = module.new_relic[*].chart_version
  description = "chart version used for new-relic helmchart"
}
output "new_relic_repository" {
  value       = module.new_relic[*].repository
  description = "helm repository url of new-relic"
}

#----------- VELERO ----------------
output "velero_service_account" {
  value       = module.velero[*].service_account
  description = "name of velero service-account"
}
output "velero_iam_policy" {
  value       = module.velero[*].iam_policy
  description = "IAM Policy name used in velero irsa"
}
output "velero_namespace" {
  value       = module.velero[*].namespace
  description = "Namespace where velero is installed"
}
output "velero_chart_version" {
  value       = module.velero[*].chart_version
  description = "chart version used for velero helmchart"
}
output "velero_repository" {
  value       = module.velero[*].repository
  description = "helm repository url of velero"
}

#----------- KUBE-STATE-METRICS ------------------------
output "kube_state_metrics_namespace" {
  value       = module.kube_state_metrics[*].namespace
  description = "The namespace where Kube-State-Metrics is deployed."
}
output "kube_state_metrics_chart_version" {
  value       = module.kube_state_metrics[*].chart_version
  description = "Chart version of the Kube-State-Metrics Helm Chart."
}
output "kube_state_metrics_repository" {
  value       = module.kube_state_metrics[*].repository
  description = "Helm chart repository of the Kube-State-Metrics."
}

#----------- KEDA ------------------------
output "keda_namespace" {
  value       = module.keda[*].namespace
  description = "The namespace where Keda is deployed."
}
output "keda_chart_version" {
  value       = module.keda[*].chart_version
  description = "Chart version of the Keda Helm Chart."
}
output "keda_repository" {
  value       = module.keda[*].repository
  description = "Helm chart repository of the Keda."
}

#----------- CERTICATION-MANAGER ------------------------
output "certification_manager_namespace" {
  value       = module.certification_manager[*].namespace
  description = "The namespace where certification-manager is deployed."
}
output "certification_manager_chart_version" {
  value       = module.certification_manager[*].chart_version
  description = "Chart version of the certification-manager Helm Chart."
}
output "certification_manager_repository" {
  value       = module.certification_manager[*].repository
  description = "Helm chart repository of the certification-manager."
}

#----------- FILEBEAT ------------------------
output "filebeat_namespace" {
  value       = module.filebeat[*].namespace
  description = "Namespace where Filebeat is installed"
}
output "filebeat_chart_version" {
  value       = module.filebeat[*].chart_version
  description = "chart version used for Filebeat helmchart"
}
output "filebeat_repository" {
  value       = module.filebeat[*].repository
  description = "helm repository url of Filebeat"
}

#----------- RELOADER ----------------------------------
output "reloader_namespace" {
  value       = module.reloader[*].namespace
  description = "The namespace where reloader is deployed."
}
output "reloader_chart_version" {
  value       = module.reloader[*].chart_version
  description = "Chart version of the reloader Helm Chart."
}
output "reloader_repository" {
  value       = module.reloader[*].repository
  description = "Helm chart repository of the reloader."
}

#----------- EXTERNAL DNS ----------------------------------
output "external_dns_namespace" {
  value       = module.reloader[*].namespace
  description = "The namespace where external dns is deployed."
}
output "external_dns_chart_version" {
  value       = module.reloader[*].chart_version
  description = "Chart version of the external dns Helm Chart."
}
output "external_dns_repository" {
  value       = module.reloader[*].repository
  description = "Helm chart repository of the external dns."
}

#----------- REDIS ----------------------------------
output "redis_namespace" {
  value       = module.redis[*].namespace
  description = "The namespace where Redis is deployed."
}
output "redis_chart_version" {
  value       = module.redis[*].chart_version
  description = "Chart version of the Redis Helm Chart."
}
output "redis_repository" {
  value       = module.redis[*].repository
  description = "Helm chart repository of the Redis."
}

#----------- ACTIONS-RUNNER-CONTROLLER ------------------------
output "actions_runner_controller_namespace" {
  value       = module.actions_runner_controller[*].namespace
  description = "The namespace where actions_runner_controller is deployed."
}
output "actions_runner_controller_chart_version" {
  value       = module.actions_runner_controller[*].chart_version
  description = "Chart version of the actions_runner_controller Helm Chart."
}
output "actions_runner_controller_repository" {
  value       = module.actions_runner_controller[*].repository
  description = "Helm chart repository of the actions_runner_controller."
}

#----------- PROMETHEUS ------------------------
output "prometheus_namespace" {
  value       = module.prometheus[*].namespace
  description = "The namespace where prometheus is deployed."
}
output "prometheus_chart_version" {
  value       = module.prometheus[*].chart_version
  description = "Chart version of the prometheus Helm Chart."
}
output "prometheus_repository" {
  value       = module.prometheus[*].repository
  description = "Helm chart repository of the prometheus."
}

#----------- GRAFANA ------------------------
output "grafana_namespace" {
  value       = module.grafana[*].namespace
  description = "The namespace where grafana is deployed."
}
output "grafana_chart_version" {
  value       = module.grafana[*].chart_version
  description = "Chart version of the grafana Helm Chart."
}
output "grafana_repository" {
  value       = module.grafana[*].repository
  description = "Helm chart repository of the grafana."
}

#----------- Prometheus Cloudwatch Exporter ------------------------
output "prometheus_cloudwatch_exporter_namespace" {
  value       = module.prometheus_cloudwatch_exporter[*].namespace
  description = "The namespace where Prometheus Cloudwatch Exporter is deployed."
}
output "prometheus_cloudwatch_exporter_chart_version" {
  value       = module.prometheus_cloudwatch_exporter[*].chart_version
  description = "Chart version of the Prometheus Cloudwatch Exporter Helm Chart."
}
output "prometheus_cloudwatch_exporter_repository" {
  value       = module.prometheus_cloudwatch_exporter[*].repository
  description = "Helm chart repository of the Prometheus Cloudwatch Exporter."
}

#----------- LOKI ------------------------
output "loki_namespace" {
  value       = module.loki[*].namespace
  description = "The namespace where loki is deployed."
}
output "loki_chart_version" {
  value       = module.loki[*].chart_version
  description = "Chart version of the loki Helm Chart."
}
output "loki_repository" {
  value       = module.loki[*].repository
  description = "Helm chart repository of the loki."
}

#----------- JAEGERS ------------------------
output "jaeger_namespace" {
  value       = module.jaeger[*].namespace
  description = "The namespace where jaeger is deployed."
}
output "jaeger_chart_version" {
  value       = module.jaeger[*].chart_version
  description = "Chart version of the jaeger Helm Chart."
}
output "jaeger_repository" {
  value       = module.jaeger[*].repository
  description = "Helm chart repository of the jaeger."
}