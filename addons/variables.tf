#-----------METRIC SERVER-------------
variable "enable_metrics_server" {
  description = "Enable metrics server add-on"
  type        = bool
  default     = false
}

variable "metrics_server_helm_config" {
  description = "Metrics Server Helm Chart config"
  type        = any
  default     = {}
}

variable "enable_cluster_autoscaler" {
  description = "Enable metrics server add-on"
  type        = bool
  default     = false
}

variable "cluster_autoscaler_helm_config" {
  description = "Metrics Server Helm Chart config"
  type        = any
  default     = {}
}

variable "enable_aws_load_balancer_controller" {
  description = "Enable metrics server add-on"
  type        = bool
  default     = false
}

variable "aws_load_balancer_controller_helm_config" {
  description = "Metrics Server Helm Chart config"
  type        = any
  default     = {}
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
