#-----------METRIC SERVER-------------
variable "enable_metrics_server" {
  description = "Enable metrics server add-on"
  type        = bool
  default     = false
}

variable "metrics_server_helm_config" {
  description = "Metrics Server Helm Chart config"
  type        = any
  default     = null
}

variable "enable_cluster_autoscaler" {
  description = "Enable Cluster Autoscaler add-on"
  type        = bool
  default     = false
}

variable "cluster_autoscaler_helm_config" {
  description = "Cluster Autoscaler Helm Chart config"
  type        = any
  default     = null
}

variable "enable_aws_load_balancer_controller" {
  description = "Enable AWS Load Balancer Controller add-on"
  type        = bool
  default     = false
}

variable "aws_load_balancer_controller_helm_config" {
  description = "AWS Load Balancer Controller Helm Chart config"
  type        = any
  default     = null
}

variable "enable_aws_node_termination_handler" {
  description = "Enable AWS Node Termination Handler add-on"
  type        = bool
  default     = false
}

variable "aws_node_termination_handler_helm_config" {
  description = "AWS Node Termination Handler Helm Chart config"
  type        = any
  default     = null
}

variable "enable_aws_efs_csi_driver" {
  description = "Enable AWS EFS CSI Driver add-on"
  type        = bool
  default     = false
}

variable "aws_efs_csi_driver_helm_config" {
  description = "AWS EFS CSI Driver Helm Chart config"
  type        = any
  default     = null
}

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
