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

# ------------------ METRICS SERVER --------------------------
variable "metrics_server_helm_config" {
  type    = any
  default = null
}

# ------------------ CLUSTER AUTOSCALER --------------------------
variable "cluster_autoscaler_helm_config" {
  type    = any
  default = null
}

# ------------------ AWS LOAD BALANCER CONTROLLER ----------
variable "aws_load_balancer_controller_helm_config" {
  type    = any
  default = null
}

# ------------------ AWS NODE TERMINATION HANDLER ----------
variable "aws_node_termination_handler_helm_config" {
  type    = any
  default = null
}

# ------------------ AWS EFS CSI DRIVER --------------------
variable "aws_efs_csi_driver_helm_config" {
  type    = any
  default = null
}

# ------------------ AWS EBS CSI DRIVER ------------------
variable "aws_ebs_csi_driver_helm_config" {
  type    = any
  default = null
}

# ------------------ KARPENTER ---------------------------
variable "karpenter_helm_config" {
  type    = any
  default = null
}


# ------------------ ISTIO INGRESS -----------------------
variable "istio_ingress_helm_config" {
  type    = any
  default = null
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


#-----------KAILI DASHBOARD-----------------------
variable "kiali_server_helm_config" {
  description = "Kiali Server Helm Chart config"
  type        = any
  default     = null
}

variable "kiali_manifests" {
  type = object({
    kiali_token_secret_file_path   = string
    kiali_virtualservice_file_path = string
    enable_monitoring              = bool
  })
  default = {
    kiali_token_secret_file_path   = "./config/kiali/kiali_secret.yaml"
    kiali_virtualservice_file_path = "./config/kiali/kiali_vs.yaml"
    enable_monitoring              = true
  }
}