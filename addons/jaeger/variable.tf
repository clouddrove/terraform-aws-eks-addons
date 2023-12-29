variable "enable_kafka" {
  description = "Whether to create kafka dependency or not."
  type        = bool
  default     = false
}

variable "enable_cassandra" {
  description = "Whether to create cassandra dependency or not."
  type        = bool
  default     = false
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

variable "jaeger_extra_configs" {
  description = "Override attributes of helm_release terraform resource for jaeger"
  type        = any
  default     = {
    enable_cassandra = false
    enable_kafka     = false
  }
}

variable "cassandra_extra_configs" {
  description = "Override attributes of helm_release terraform resource for cassandra"
  type        = any
  default     = {}
}

variable "kafka_extra_configs" {
  description = "Override attributes of helm_release terraform resource for kafka"
  type        = any
  default     = {}
}

variable "helm_config" {
  description = "Helm provider config for AWS Load Balancer Controller for jaeger"
  type        = any
  default     = {}
}

variable "jaeger_extra_manifests" {
  type = object({
    jaeger_cassandra_file_path = list(any)
    jaeger_kafka_file_path     = list(any)
  })
  default = {
    jaeger_cassandra_file_path = [""]
    jaeger_kafka_file_path     = [""]
  }
  description = "Path of override files to create customized depedency helm charts for jaeger"
}