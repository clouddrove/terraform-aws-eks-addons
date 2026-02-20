terraform {
  required_version = ">= 1.5.4"

  required_providers {
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = ">= 2.10"
    }
    aws = {
      source  = "hashicorp/aws"
      version = ">= 3.72"
    }
    kubectl = {
      source  = "gavinbunney/kubectl"
      version = ">= 1.7.0"
    }
  }
}
