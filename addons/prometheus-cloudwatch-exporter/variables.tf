variable "helm_config" {
  description = "Helm provider config for Prometheus Cloudwatch Exporter"
  type        = any
  default     = {}
}

variable "manage_via_gitops" {
  description = "Determines if the add-on should be managed via GitOps"
  type        = bool
  default     = false
}

variable "addon_context" {
  description = "Input configuration for the addon"
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

variable "prometheus_cloudwatch_exporter_extra_configs" {
  description = "Override attributes of helm_release terraform resource"
  type        = any
  default     = {}
}

variable "secret_manifest" {
  description = "Path of Ingress and Gateway yaml manifests"
  type        = list(any)
  default     = []
}

variable "eks_cluster_name" {
  type    = string
  default = ""
}

variable "iampolicy_json_content" {
  description = "Custom IAM Policy for Prometheus Cloudwatch Exporter's Role"
  type        = string
  default     = null
}