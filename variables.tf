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

#-----------AWS EBS CSI DRIVER --------------------
variable "aws_ebs_csi_driver" {
  description = "Enable AWS EBS CSI Driver add-on"
  type        = bool
  default     = false
}

variable "aws_ebs_csi_driver_helm_config" {
  description = "AWS EBS CSI Driver Helm Chart config"
  type        = any
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