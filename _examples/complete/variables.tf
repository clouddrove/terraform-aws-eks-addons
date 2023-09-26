# ------------------------------------------------------------------------------
# Variables
# ------------------------------------------------------------------------------

# ------------------ ISTIO INGRESS ---------------------------------------------
variable "istio_manifests" {
  type = object({
    istio_ingress_manifest_file_path = list(any)
    istio_gateway_manifest_file_path = list(any)
  })
  default = {
    istio_ingress_manifest_file_path = ["./config/istio/ingress.yaml", "./config/istio/ingress-internal.yaml"]
    istio_gateway_manifest_file_path = ["./config/istio/gateway.yaml"]
  }
  description = "Path to yaml manifests to create Ingress and Gateway with specified host"
}

#-----------KAILI DASHBOARD-----------------------------------------------------
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
    secret_manager_name                 = "external_secrets"
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
    name             = "istio-ingress"
    namespace        = "istio-system"
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

variable "fluent_bit_extra_configs" {
  type = any
  default = {
    atomic  = true
    timeout = 300
  }
}

variable "velero_extra_configs" {
  type = any
  default = {
    timeout     = 300
    atomic      = true
    bucket_name = "velero-addons"
  }
}

variable "new_relic_extra_configs" {
  type    = any
  default = {}
}

variable "kube_state_metrics_extra_configs" {
  type    = any
  default = {}
}