# ------------------------------------------------------------------------------
# Variables
# ------------------------------------------------------------------------------

variable "region" {
  type        = string
  default     = "us-east-1"
  description = "Region Code"
}

variable "cluster_endpoint_public_access" {
  type        = bool
  default     = true
  description = "Indicates whether or not the Amazon EKS public API server endpoint is enabled"
}

variable "cluster_endpoint_private_access" {
  type        = bool
  default     = true
  description = "Indicates whether or not the Amazon EKS private API server endpoint is enabled"
}

variable "token" {
  type        = string
  description = "Token for efs csi driver"
  default     = "test-addon-efs"
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
  description = "Path to yaml manifests to create Ingress and Gateway with specified host"
}

variable "kiali_manifests" {
  type = object({
    kiali_virtualservice_file_path = string
  })
  default = {
    kiali_virtualservice_file_path = "./config/kiali/kiali_vs.yaml"
  }
  description = "Path to VirtualService manifest for kiali-dashboard"
}

variable "externalsecrets_manifests" {
  type = object({
    secret_store_manifest_file_path     = string
    external_secrets_manifest_file_path = string
    secret_manager_name                 = string
  })
  default = {
    secret_store_manifest_file_path     = "./config/external-secret/secret-store.yaml"
    external_secrets_manifest_file_path = "./config/external-secret/external-secret.yaml"
    secret_manager_name                 = "external_secrets"
  }
  description = "yaml manifest file path to create ExternalSecret, SecretStore and custome SecretManger name"
}