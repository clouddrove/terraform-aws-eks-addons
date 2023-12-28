# ------------------------------------------------------------------------------
# Variables
# ------------------------------------------------------------------------------

# ------------------ METRICS SERVER --------------------------------------------
variable "metrics_server_extra_configs" {
  type    = any
  default = {}
}

# ------------------ CLUSTER AUTOSCALER ----------------------------------------
variable "cluster_autoscaler_extra_configs" {
  type    = any
  default = {}
}

# ------------------ KARPENTER -------------------------------------------------
variable "karpenter_extra_configs" {
  type    = any
  default = {}
}

# ------------------ LOAD BALANCER CONTROLLER ----------------------------------
variable "aws_load_balancer_controller_extra_configs" {
  type    = any
  default = {}
}

# ------------------ NODE TERMINATION HANDLER ----------------------------------
variable "aws_node_termination_handler_extra_configs" {
  type    = any
  default = {}
}

# ------------------ EFS CSI DRIVER --------------------------------------------
variable "aws_efs_csi_driver_extra_configs" {
  type    = any
  default = {}
}

# ------------------ EBS CSI DRIVER --------------------------------------------
variable "aws_ebs_csi_driver_extra_configs" {
  type    = any
  default = {}
}

# ------------------ CALICO ----------------------------------------------------
variable "calico_tigera_extra_configs" {
  type    = any
  default = {}
}

# ------------------ NGINX INGRESS ---------------------------------------------
variable "ingress_nginx_extra_configs" {
  type    = any
  default = {}
}

# ------------------ KUBECLARITY -----------------------------------------------
variable "kubeclarity_extra_configs" {
  type    = any
  default = {}
}

# ------------------ FLUENT-BIT ------------------------------------------------
variable "fluent_bit_extra_configs" {
  type = any
  default = {
    atomic  = true
    timeout = 300
  }
}

# ------------------ VELERO ----------------------------------------------------
variable "velero_extra_configs" {
  type = any
  default = {
    timeout     = 300
    atomic      = true
    bucket_name = "velero-addons"
  }
}

# ------------------ NEW-RELIC -------------------------------------------------
variable "new_relic_extra_configs" {
  type    = any
  default = {}
}

# ------------------ KUBE STATE METRICS ----------------------------------------
variable "kube_state_metrics_extra_configs" {
  type    = any
  default = {}
}

# ------------------ KEDA -----------------------------------------------------
variable "keda_extra_configs" {
  type    = any
  default = {}
}

# ------------------ CERTIFICATION-MANAGER -----------------------------------------------------
variable "certification_manager_extra_configs" {
  type    = any
  default = {}
}


# ------------------ ISTIO INGRESS ---------------------------------------------
# -- INTERNET FACING --------------
variable "istio_manifests" {
  type = object({
    istio_ingress_manifest_file_path = list(any)
    istio_gateway_manifest_file_path = list(any)
  })
  default = {
    istio_ingress_manifest_file_path = ["./config/istio/ingress.yaml"]
    istio_gateway_manifest_file_path = ["./config/istio/gateway.yaml"]
  }
  description = "Path to yaml manifests to create Ingress and Gateway with specified host"
}

variable "istio_ingress_extra_configs" {
  type = any
  default = {
    name             = "istio-ingress"
    namespace        = "istio-system"
    create_namespace = true
  }
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

variable "kiali_server_extra_configs" {
  type    = any
  default = {}
}

# ------------------ EXTERNAL SECRETS ------------------------------------------
variable "external_secrets_extra_configs" {
  type = any
  default = {
    secret_manager_name = "external_secrets_addon"
  }
}

# ------------------ FILEBEAT -------------------------------------------------
variable "filebeat_extra_configs" {
  type    = any
  default = {}
}

# ------------------ RELOADER --------------------------------------------------
variable "reloader_extra_configs" {
  type    = any
  default = {}
}

# ------------------ REDIS --------------------------------------------------
variable "redis_extra_configs" {
  type = any
  default = {
    atomic  = true
    timeout = 300
  }
}

# ---------------------- PROMETHEUS-CLOUDWATCH-EXPORTER ------------------------------------------------
variable "prometheus_cloudwatch_exporter_extra_configs" {
  type = any
  default = {
    role_name = ""
  }
}
