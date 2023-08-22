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

# ------------------ ISTIO INGRESS ---------------------------------------------
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

#-----------KAILI DASHBOARD-----------------------------------------------------
variable "kiali_server_helm_config" {
  description = "Kiali Server Helm Chart config"
  type        = any
  default     = null
}

variable "kiali_manifests" {
  type = object({
    kiali_virtualservice_file_path = string
  })
  default = {
    kiali_virtualservice_file_path = "./config/kiali/kiali_vs.yaml"
  }
}

# ------------------ EXTERNAL SECRETS ------------------------------------------
variable "externalsecrets_manifests" {
  type = object({
    secret_store_manifest_file_path     = string
    external_secrets_manifest_file_path = string
    secret_manager_name                 = string
  })
  default = {
    secret_store_manifest_file_path     = "./config/external-secret/secret-store.yaml"
    external_secrets_manifest_file_path = "./config/external-secret/external-secret.yaml"
    secret_manager_name                 = "external_secrets-test6"
  }
}

#--------------OVERRIDE HELM RELEASE ATTRIBUTES --------------------------------
variable "metrics_server_extra_configs" {
  type    = any
  default = {}
}

variable "cluster_autoscaler_extra_configs" {
  type    = any
  default = {}
}

variable "karpenter_extra_configs" {
  type    = any
  default = {}
}

variable "aws_load_balancer_controller_extra_configs" {
  type    = any
  default = {}
}

variable "aws_node_termination_handler_extra_configs" {
  type    = any
  default = {}
}

variable "aws_efs_csi_driver_extra_configs" {
  type    = any
  default = {}
}

variable "aws_ebs_csi_driver_extra_configs" {
  type    = any
  default = {}
}

variable "calico_tigera_extra_configs" {
  type    = any
  default = {}
}

variable "istio_ingress_extra_configs" {
  type = any
  default = {
    namespace        = "istio"
    create_namespace = true
  }
}

variable "kiali_server_extra_configs" {
  type    = any
  default = {}
}

variable "external_secrets_extra_configs" {
  type    = any
  default = {}
}

variable "ingress_nginx_extra_configs" {
  type    = any
  default = {}
}

variable "kubeclarity_extra_configs" {
  type    = any
  default = {}
}
