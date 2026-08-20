variable "helm_config" {
  description = "Helm chart config. Repository and version required. See https://registry.terraform.io/providers/hashicorp/helm/latest/docs"
  type        = any
  default     = {}
}

variable "set_values" {
  description = "Forced set values"
  type        = any
  default     = []
}

variable "irsa_config" {
  description = "Input configuration for IRSA module"
  type        = any
  default     = {}
}

variable "addon_context" {
  description = "IRSA Input configuration for the addon"
  type        = any
}

variable "irsa_assume_role_policy" {
  description = "Custom Trust Relationship policy for IAM Role"
  type        = any
  default     = null
}