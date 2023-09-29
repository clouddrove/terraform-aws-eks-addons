variable "helm_config" {
  description = "Helm provider config for Metrics Server"
  type        = any
  default     = {}
}

variable "manage_via_gitops" {
  description = "Determines if the add-on should be managed via GitOps"
  type        = bool
  default     = false
}

variable "eks_cluster_name" {
  type    = string
  default = ""
}

variable "account_id" {
  description = "Account ID of AWS Account"
  type        = string
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

variable "external_secrets_extra_configs" {
  description = "Override attributes of helm_release terraform resource"
  type        = any
  default     = {}
}

variable "irsa_assume_role_policy" {
  description = "Custom Trust Relationship policy for IAM Role"
  type        = any
  default     = null
}