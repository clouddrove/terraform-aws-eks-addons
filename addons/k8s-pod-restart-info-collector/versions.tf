terraform {
  required_version = ">= 1.14.5"

  required_providers {
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = ">= 2.10"
    }
    aws = {
      source  = "hashicorp/aws"
      version = ">= 3.72"
    }
  }
}