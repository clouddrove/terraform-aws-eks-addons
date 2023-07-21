# ------------------------------------------------------------------------------
# Variables
# ------------------------------------------------------------------------------

variable "region" {
  type        = string
  default     = "us-east-1"
  description = "Region Code"
}

variable "cluster_endpoint_public_access" {
  type    = bool
  default = true
}

variable "cluster_endpoint_private_access" {
  type    = bool
  default = true
}

variable "iam_role_use_name_prefix" {
  type    = string
  default = "terraform-helm-eks-addons"
}

variable "token" {
  type    = string
  default = "test-addon-efs"
}

variable "istio_manifests" {
  type = object({
    istio_ingress_manifest_file_path = string
    istio_gateway_manifest_file_path = string
  })
  default = {
    istio_ingress_manifest_file_path = "./config/istio/ingress.yaml"
    istio_gateway_manifest_file_path = "./config/istio/gateway.yaml"
  }
}

#---------------------- K8S POD RESTART INFO COLLECTOR ----------------
variable "slack_config" {
  type = object({
    slack_webhook_url = string
    slack_channel     = string
  })
  default = {
    slack_webhook_url = "https://hooks.slack.com/services/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"
    slack_channel     = "alert"
  }
}