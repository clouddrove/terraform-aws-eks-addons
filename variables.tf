#-----------METRIC SERVER----------------------
variable "metrics_server" {
  description = "Enable metrics server add-on"
  type        = bool
  default     = false
}

variable "metrics_server_helm_config" {
  description = "Path to override-values.yaml for Metrics Server Helm Chart"
  type        = any
  default     = null
}

variable "metrics_server_extra_configs" {
  description = "Override attributes of helm_release terraform resource"
  type        = any
  default     = {}
}

#-----------CLUSTER AUTOSCALER------------------
variable "cluster_autoscaler" {
  description = "Enable Cluster Autoscaler add-on"
  type        = bool
  default     = false
}

variable "cluster_autoscaler_helm_config" {
  description = "Path to override-values.yaml for Cluster Autoscaler Helm Chart"
  type        = any
  default     = null
}

variable "cluster_autoscaler_extra_configs" {
  description = "Override attributes of helm_release terraform resource"
  type        = any
  default     = {}
}

variable "cluster_autoscaler_iampolicy_json_content" {
  description = "Custom IAM Policy for ClusterAutoscaler IRSA"
  type        = string
  default     = null
}

#-----------AWS LOAD BALANCER CONTROLLER --------
variable "aws_load_balancer_controller" {
  description = "Enable AWS Load Balancer Controller add-on"
  type        = bool
  default     = false
}

variable "aws_load_balancer_controller_helm_config" {
  description = "Path to override-values.yaml for AWS Load Balancer Controller Helm Chart"
  type        = any
  default     = null
}

variable "aws_load_balancer_controller_extra_configs" {
  description = "Override attributes of helm_release terraform resource"
  type        = any
  default     = {}
}

variable "aws_load_balancer_controller_iampolicy_json_content" {
  description = "Custom IAM Policy for Load Balancer Controller IRSA"
  type        = string
  default     = null
}

#-----------AWS NODE TERMINATION HANDLER --------
variable "aws_node_termination_handler" {
  description = "Enable AWS Node Termination Handler add-on"
  type        = bool
  default     = false
}

variable "aws_node_termination_handler_helm_config" {
  description = "Path to override-values.yaml for AWS Node Termination Handler Helm Chart"
  type        = any
  default     = null
}

variable "aws_node_termination_handler_extra_configs" {
  description = "Override attributes of helm_release terraform resource"
  type        = any
  default     = {}
}

#-----------AWS EFS CSI DRIVER --------------------
variable "aws_efs_csi_driver" {
  description = "Enable AWS EFS CSI Driver add-on"
  type        = bool
  default     = false
}

variable "aws_efs_csi_driver_helm_config" {
  description = "Path to override-values.yaml for AWS EFS CSI Driver Helm Chart"
  type        = any
  default     = null
}

variable "aws_efs_csi_driver_extra_configs" {
  description = "Override attributes of helm_release terraform resource"
  type        = any
  default     = {}
}

variable "aws_efs_csi_driver_iampolicy_json_content" {
  description = "Custom IAM Policy for EFS CSI Driver IRSA"
  type        = string
  default     = null
}

#-----------AWS EBS CSI DRIVER --------------------
variable "aws_ebs_csi_driver" {
  description = "Enable AWS EBS CSI Driver add-on"
  type        = bool
  default     = false
}

variable "aws_ebs_csi_driver_helm_config" {
  description = "Path to override-values.yaml for EBS CSI Driver Helm Chart"
  type        = any
  default     = null
}

variable "aws_ebs_csi_driver_extra_configs" {
  description = "Override attributes of helm_release terraform resource"
  type        = any
  default     = {}
}

variable "aws_ebs_csi_driver_iampolicy_json_content" {
  description = "Custom IAM Policy for EBS CSI Driver IRSA"
  type        = string
  default     = null
}

#-----------KARPENTER -----------------------------
variable "karpenter" {
  description = "Enable KARPENTER add-on"
  type        = bool
  default     = false
}

variable "karpenter_helm_config" {
  description = "Path to override-values.yaml for Karpenter Helm Chart"
  type        = any
  default     = null
}

variable "karpenter_extra_configs" {
  description = "Override attributes of helm_release terraform resource"
  type        = any
  default     = {}
}

variable "karpenter_iampolicy_json_content" {
  description = "Custom IAM Policy for Karpenter IRSA"
  type        = string
  default     = null
}

#-----------ISTIO INGRESS---------------------------
variable "istio_ingress" {
  description = "Enable Istio Ingress add-on"
  type        = bool
  default     = false
}

variable "istio_ingress_helm_config" {
  description = "Path to override-values.yaml for Istio Ingress  Helm Chart"
  type        = any
  default     = null
}

variable "istio_manifests" {
  description = "Path of Ingress and Gateway yaml manifests"
  type = object({
    istio_ingress_manifest_file_path = list(any)
    istio_gateway_manifest_file_path = list(any)
  })
  default = {
    istio_ingress_manifest_file_path = [""]
    istio_gateway_manifest_file_path = [""]
  }
}

variable "istio_ingress_extra_configs" {
  description = "Override attributes of helm_release terraform resource"
  type        = any
  default     = {}
}

#-----------KAILI DASHBOARD-----------------------
variable "kiali_server" {
  description = "Enable kiali server add-on"
  type        = bool
  default     = false
}

variable "kiali_server_helm_config" {
  description = "Path to override-values.yaml for Kiali Server Helm Chart"
  type        = any
  default     = null
}


variable "kiali_manifests" {
  description = "Path of virtual-service yaml manifests"
  type = object({
    kiali_virtualservice_file_path = string
  })
  default = {
    kiali_virtualservice_file_path = ""
  }
}

variable "kiali_server_extra_configs" {
  description = "Override attributes of helm_release terraform resource"
  type        = any
  default     = {}
}

#-----------CALICO TOGERA --------------------------
variable "calico_tigera" {
  description = "Enable Tigera's Calico add-on"
  type        = bool
  default     = false
}

variable "calico_tigera_helm_config" {
  description = "Path to override-values.yaml for Calico Helm Chart"
  type        = any
  default     = null
}

variable "calico_tigera_extra_configs" {
  description = "Override attributes of helm_release terraform resource"
  type        = any
  default     = {}
}

#----------- EXTERNAL SECRETS ---------------------
variable "external_secrets" {
  description = "Enable External-Secrets add-on"
  type        = bool
  default     = false
}

variable "external_secrets_helm_config" {
  description = "Path to override-values.yaml for External-Secrets Helm Chart"
  type        = any
  default     = null
}

variable "external_secrets_extra_configs" {
  description = "Override attributes of helm_release terraform resource"
  type        = any
  default     = {}
}

variable "external_secrets_iampolicy_json_content" {
  description = "Custom IAM Policy for External-Secrets IRSA"
  type        = string
  default     = null
}

#------------------ INGRESS NGINX -------------------------
variable "ingress_nginx" {
  description = "Enable ingress nginx add-on"
  type        = bool
  default     = false
}

variable "ingress_nginx_helm_config" {
  description = "Path to override-values.yaml for Ingress Nginx Helm Chart"
  type        = any
  default     = null
}

variable "ingress_nginx_extra_configs" {
  description = "Override attributes of helm_release terraform resource"
  type        = any
  default     = null
}

#-----------KUBECLARITY---------------------------
variable "kubeclarity" {
  description = "Enable Kubeclarity add-on"
  type        = bool
  default     = false
}

variable "kubeclarity_helm_config" {
  description = "Path to override-values.yaml for Kubeclarity Helm Chart"
  type        = any
  default     = null
}

variable "kubeclarity_extra_configs" {
  description = "Override attributes of helm_release terraform resource"
  type        = any
  default     = {}
}

#----------- NEW RELIC AGENT ----------------------
variable "new_relic" {
  description = "Enable New-Relic-Agent add-on"
  type        = bool
  default     = false
}

variable "new_relic_helm_config" {
  description = "New-Relic Helm Chart config"
  type        = any
  default     = null
}

variable "new_relic_extra_configs" {
  description = "Override attributes of helm_release terraform resource"
  type        = any
  default     = {}
}

#----------- KUBE STATE METRICS ----------------------
variable "kube_state_metrics" {
  description = "Enable Kube-State-Metrics add-on"
  type        = bool
  default     = false
}

variable "kube_state_metrics_helm_config" {
  description = "Kube-State-Metrics Helm Chart config"
  type        = any
  default     = null
}

variable "kube_state_metrics_extra_configs" {
  description = "Override attributes of helm_release terraform resource"
  type        = any
  default     = {}
}

#-----------COMMON VARIABLES -----------------------
variable "tags" {
  description = "IRSA Input configuration for the addon_context"
  type        = any
  default     = {}
}

variable "irsa_iam_role_path" {
  description = "IRSA Input configuration for the addon_context"
  type        = any
  default     = {}
}

variable "irsa_iam_permissions_boundary" {
  description = "IRSA Input configuration for the addon_context"
  type        = any
  default     = {}
}

variable "manage_via_gitops" {
  type        = bool
  default     = false
  description = "Set this to `true` if managing addons via GitOps. Seting `true` will not create helm-release for addon."
}

variable "data_plane_wait_arn" {
  description = "This waits for the data plane to be ready"
  type        = string
  default     = ""
}

variable "eks_cluster_name" {
  description = "Name of eks cluster"
  type        = string
  default     = ""
}

#----------- FLUENT-BIT ----------------------------
variable "fluent_bit" {
  description = "Enable FluentBit add-on"
  type        = bool
  default     = false
}

variable "fluent_bit_helm_config" {
  description = "Path to override-values.yaml for FluentBit Helm Chart"
  type        = any
  default     = null
}

variable "fluent_bit_extra_configs" {
  description = "Override attributes of helm_release terraform resource"
  type        = any
  default     = {}
}

variable "fluent_bit_iampolicy_json_content" {
  description = "Custom IAM Policy for FluentBit IRSA"
  type        = string
  default     = null
}

#----------- VELERO ----------------------------
variable "velero" {
  description = "Enable Velero add-on"
  type        = bool
  default     = false
}

variable "velero_helm_config" {
  description = "Path to override-values.yaml for Velero Helm Chart"
  type        = any
  default     = null
}

variable "velero_extra_configs" {
  description = "Override attributes of helm_release terraform resource"
  type        = any
  default     = {}
}

variable "velero_iampolicy_json_content" {
  description = "Custom IAM Policy for Velero IRSA"
  type        = string
  default     = null
}

#----------- KEDA ----------------------------
variable "keda" {
  description = "Enable Keda add-on"
  type        = bool
  default     = false
}

variable "keda_helm_config" {
  description = "Path to override-values.yaml for Keda Helm Chart"
  type        = any
  default     = null
}

variable "keda_extra_configs" {
  description = "Override attributes of helm_release terraform resource"
  type        = any
  default     = {}
}

#-----------CERTIFICATION-MANAGER----------------------
variable "certification_manager" {
  description = "Enable certification_manager add-on"
  type        = bool
  default     = false
}

variable "certification_manager_helm_config" {
  description = "Path to override-values.yaml for Certification Manager Chart"
  type        = any
  default     = null
}

variable "certification_manager_extra_configs" {
  description = "Override attributes of helm_release terraform resource"
  type        = any
  default     = {}
}

#-------------- FILEBEAT ----------------------
variable "filebeat" {
  description = "Enable Filebeat add-on"
  type        = bool
  default     = false
}

variable "filebeat_helm_config" {
  description = "Filebeat Helm Chart config"
  type        = any
  default     = null
}

variable "filebeat_extra_configs" {
  description = "Override attributes of helm_release terraform resource"
  type        = any
  default     = {}
}

#----------- RELOADER ----------------------------
variable "reloader" {
  description = "Enable Reloader add-on"
  type        = bool
  default     = false
}

variable "reloader_helm_config" {
  description = "Path to override-values.yaml for Reloader Helm Chart"
  type        = any
  default     = null
}

variable "reloader_extra_configs" {
  description = "Override attributes of helm_release terraform resource"
  type        = any
  default     = {}
}

#----------- EXTERNAL DNS ----------------------------
variable "external_dns" {
  description = "Enable External DNS add-on"
  type        = bool
  default     = false
}

variable "external_dns_helm_config" {
  description = "Path to override-values.yaml for External DNS Helm Chart"
  type        = any
  default     = null
}

variable "external_dns_extra_configs" {
  description = "Override attributes of helm_release terraform resource"
  type        = any
  default     = {}
}

variable "external_dns_iampolicy_json_content" {
  description = "Custom IAM Policy for External DNS"
  type        = string
  default     = null
}

#----------- REDIS ----------------------------
variable "redis" {
  description = "Enable Redis add-on"
  type        = bool
  default     = false
}

variable "redis_helm_config" {
  description = "Path to override-values.yaml for Redis Helm Chart"
  type        = any
  default     = null
}

variable "redis_extra_configs" {
  description = "Override attributes of helm_release terraform resource"
  type        = any
  default     = {}
}

#-----------ACTIONS-RUNNER-CONTROLLER----------------------
variable "actions_runner_controller" {
  description = "Enable actions_runner_controller add-on"
  type        = bool
  default     = false
}

variable "actions_runner_controller_helm_config" {
  description = "Path to override-values.yaml for actions_runner_controller Chart"
  type        = any
  default     = null
}

variable "actions_runner_controller_extra_configs" {
  description = "Override attributes of helm_release terraform resource"
  type        = any
  default     = {}
}

#-----------PROMETHEUS---------------------------
variable "prometheus" {
  description = "Enable prometheus add-on"
  type        = bool
  default     = false
}

variable "prometheus_helm_config" {
  description = "Prometheus Helm Chart config"
  type        = any
  default     = null
}

variable "prometheus_extra_configs" {
  description = "Override attributes of helm_release terraform resource"
  type        = any
  default     = {}
}

#----------------------- GRAFANA -----------------------------
variable "grafana" {
  description = "Enable Grafana add-on"
  type        = bool
  default     = false
}

variable "grafana_helm_config" {
  description = "Grafana Helm Chart config"
  type        = any
  default     = null
}

variable "grafana_extra_configs" {
  description = "Override attributes of helm_release terraform resource"
  type        = any
  default     = {}
}

variable "grafana_manifests" {
  description = "Path of virtual-service yaml manifests"
  type = object({
    grafana_virtualservice_file_path = string
  })
  default = {
    grafana_virtualservice_file_path = ""
  }
}

#-----------PROMETHEUS CLOUDWATCH EXPORTER----------------------
variable "prometheus_cloudwatch_exporter" {
  description = "Enable Prometheus Cloudwatch Exporter add-on"
  type        = bool
  default     = false
}

variable "prometheus_cloudwatch_exporter_helm_config" {
  description = "Path to override-values.yaml for Promtheus Cloudwatch Exporter Chart"
  type        = any
  default     = null
}

variable "prometheus_cloudwatch_exporter_extra_configs" {
  description = "Override attributes of helm_release terraform resource"
  type        = any
  default     = {}
}

variable "prometheus_cloudwatch_exporter_secret_manifest" {
  description = "Path of prometheus cloudwatch exporter manifest"
  type        = string
  default     = null
}

variable "prometheus_cloudwatch_exporter_role_iampolicy_json_content" {
  description = "Custom IAM Policy for Prometheus Cloudwatch Exporter's Role"
  type        = string
  default     = null
}

#-----------Loki----------------------
variable "loki" {
  description = "Enable loki add-on"
  type        = bool
  default     = false
}

variable "loki_helm_config" {
  description = "Path to override-values.yaml for Loki Chart"
  type        = any
  default     = null
}

variable "loki_extra_configs" {
  description = "Override attributes of helm_release terraform resource"
  type        = any
  default     = {}
}

#-----------Jaeger----------------------
variable "jaeger" {
  description = "Enable jaeger add-on"
  type        = bool
  default     = false
}

variable "jaeger_helm_config" {
  description = "Path to override-values.yaml for Jaeger Chart"
  type        = any
  default     = null
}

variable "jaeger_extra_configs" {
  description = "Override attributes of helm_release terraform resource"
  type        = any
  default     = {}
}