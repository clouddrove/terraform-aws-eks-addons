variable "helm_config" {
  description = "Helm provider config for Nginx Ingress"
  type        = any
  default     = {}
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

variable "ingress_nginx_extra_configs" {
  description = "Nginx ingress extra config"
  type        = any
  default     = {}
}

