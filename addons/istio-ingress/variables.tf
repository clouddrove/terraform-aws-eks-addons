variable "helm_config" {
  description = "Helm provider config for Istio Ingress"
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

variable "istio_manifests" {
  type = object({
    istio_ingress_manifest_file_path = list(any)
    istio_gateway_manifest_file_path = list(any)
  })
}

variable "istio_ingress_extra_configs" {
  description = "Override attributes of helm_release terraform resource"
  type        = any
  default     = {}
}

variable "istiod_helm_config" {
  description = "Path to override-values.yaml for Istiod Helm Chart"
  type        = any
  default     = null
} 