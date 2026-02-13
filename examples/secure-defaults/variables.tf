variable "region" {
  type        = string
  description = "AWS region of the target EKS cluster"
  default     = "us-east-1"
}

variable "eks_cluster_name" {
  type        = string
  description = "Existing EKS cluster name where addons will be installed"
}
