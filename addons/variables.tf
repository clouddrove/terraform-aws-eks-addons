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

variable "eks_cluster_id" {
  type    = any
  default = {}
}

variable "argocd_manage_add_ons" {
  type    = any
  default = {}
}