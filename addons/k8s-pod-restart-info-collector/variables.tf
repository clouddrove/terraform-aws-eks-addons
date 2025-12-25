variable "helm_config" {
  description = "Helm provider config for the k8s-pod-restart-info-collector"
  type        = any
  default     = {}
}

variable "manage_via_gitops" {
  description = "Determines if the add-on should be managed via GitOps"
  type        = bool
  default     = false
}

variable "addon_context" {
  description = "Input configuration for the add-on"
  type = object({
    aws_caller_identity_account_id = string
    aws_caller_identity_arn        = string
    aws_eks_cluster_endpoint       = string
    aws_partition_id               = string
    aws_region_name                = string
    eks_cluster_id                 = string
    eks_oidc_issuer_url            = string
    eks_oidc_provider_arn          = string
    tags                           = map(string)
  })
}

variable "eks_cluster_name" {
  type    = string
  default = ""
}

variable "account_id" {
  type    = string
  default = ""
}

variable "k8s_pod_restart_info_collector" {
  description = "Flag to enable the k8s-pod-restart-info-collector add-on"
  type        = bool
  default     = false
}

variable "k8s_pod_restart_info_collector_helm_config" {
  description = "Helm configuration specific to the k8s-pod-restart-info-collector"
  type        = any
  default     = {}
}

variable "k8s_pod_restart_info_collector_extra_configs" {
  description = "Override attributes of helm_release terraform resource for k8s-pod-restart-info-collector"
  type        = any
  default     = {}
}

variable "k8s_pod_restart_info_collector_iampolicy_json_content" {
  description = "Custom IAM Policy for the k8s-pod-restart-info-collector IRSA"
  type        = string
  default     = null
}