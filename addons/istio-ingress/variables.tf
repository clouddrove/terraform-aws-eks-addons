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

variable "eks_cluster_name" {
  type    = string
  default = ""
}

variable "eks_cluster_id" {
  type    = string
  default = ""
}

variable "account_id" {
  type    = string
  default = ""
}

variable "set_values" {
  type    = any
  default = []
}

variable "istio_manifests" {
  type = object({
    istio_ingress_manifest_file_path = string
    istio_gateway_manifest_file_path = string
  })
}

# variable "istio_ingress_default_helm_config" {
#   type = object({
#     name        = string
#     chart       = string
#     repository  = string
#     version     = string
#     namespace   = string
#     description = string
#   })
#   default = {
#     name        = "istio-ingressgateway"
#     chart       = "gateway"
#     repository  = "https://istio-release.storage.googleapis.com/charts"
#     version     = "1.18.0"
#     namespace   = "istio-system"
#     description = "Istio Ingress helm Chart deployment configuration"
#   }
# }

variable "istio_ingress_extra_configs" {
  description = "Override attributes of helm_release terraform resource"
  type        = any
  default     = {}
}