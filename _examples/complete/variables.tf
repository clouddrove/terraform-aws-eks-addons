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
}

variable "cluster_endpoint_private_access" {
    type        = bool
    default     = true
}

variable "iam_role_use_name_prefix" {
    type        = string
    default     = "terraform-helm-eks-addons"
}

