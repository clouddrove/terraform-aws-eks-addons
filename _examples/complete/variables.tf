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