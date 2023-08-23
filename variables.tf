#-----------METRIC SERVER----------------------
variable "metrics_server" {
  description = "Enable metrics server add-on"
  type        = bool
  default     = false
}

variable "metrics_server_helm_config" {
  description = "Metrics Server Helm Chart config"
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
  description = "Cluster Autoscaler Helm Chart config"
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
  description = "AWS Load Balancer Controller Helm Chart config"
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
  description = "AWS Node Termination Handler Helm Chart config"
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
  description = "AWS EFS CSI Driver Helm Chart config"
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
  description = "Path to override-values.yaml"
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
  description = "Karpenter Helm Chart config"
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
  description = "Istio Ingress  Helm Chart config"
  type        = any
  default     = null
}

variable "istio_manifests" {
  type = object({
    istio_ingress_manifest_file_path = string
    istio_gateway_manifest_file_path = string
  })
  default = {
    istio_ingress_manifest_file_path = ""
    istio_gateway_manifest_file_path = ""
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
  description = "Kiali Server Helm Chart config"
  type        = any
  default     = null
}


variable "kiali_manifests" {
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
  description = "Calico Helm Chart config"
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
  description = "External-Secrets Helm Chart config"
  type        = any
  default     = null
}

variable "externalsecrets_manifests" {
  type = object({
    secret_store_manifest_file_path     = string
    external_secrets_manifest_file_path = string
    secret_manager_name                 = string
  })
  default = {
    secret_store_manifest_file_path     = ""
    external_secrets_manifest_file_path = ""
    secret_manager_name                 = "addon-external_secrets"
  }
}

variable "external_secrets_extra_configs" {
  description = "Override attributes of helm_release terraform resource"
  type        = any
  default     = {}
}

#------------------ INGRESS NGINX -------------------------
variable "ingress_nginx" {
  description = "Enable ingress nginx add-on"
  type        = bool
  default     = false
}

variable "ingress_nginx_helm_config" {
  description = "Path to override-values.yaml"
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
  description = "Kubeclarity Helm Chart config"
  type        = any
  default     = null
}

variable "kubeclarity_extra_configs" {
  description = "Override attributes of helm_release terraform resource"
  type        = any
  default     = {}
}

#-----------COMMON VARIABLES -----------------------
variable "tags" {
  type    = any
  default = {}
}

variable "irsa_iam_role_path" {
  type    = any
  default = {}
}

variable "irsa_iam_permissions_boundary" {
  type    = any
  default = {}
}

variable "manage_via_gitops" {
  type    = bool
  default = false
}

variable "data_plane_wait_arn" {
  type    = string
  default = ""
}

variable "eks_cluster_id" {
  type    = string
  default = ""
}

variable "eks_oidc_provider" {
  type    = string
  default = ""
}

variable "eks_cluster_endpoint" {
  type    = string
  default = ""
}

variable "eks_oidc_issuer_url" {
  type    = string
  default = ""
}

variable "eks_cluster_name" {
  type    = string
  default = ""
}