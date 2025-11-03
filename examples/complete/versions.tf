terraform {
  required_version = ">= 1.9.8"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 4.23"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = ">= 2.13"
    }
    helm = {
      source  = "hashicorp/helm"
      version = "3.1.0"
    }
    kubectl = {
      source  = "gavinbunney/kubectl"
      version = ">= 1.14.0"
    }
  }
}
