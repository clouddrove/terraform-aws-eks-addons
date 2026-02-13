# Secure Defaults Example

Opinionated addons stack for production-friendly secure defaults on an **existing EKS cluster**.

## Included addons
- Metrics Server
- Cluster Autoscaler
- AWS Load Balancer Controller
- AWS Node Termination Handler
- AWS EBS CSI Driver
- AWS EFS CSI Driver
- Calico Tigera
- NGINX Ingress
- External Secrets
- cert-manager
- Reloader

## Usage
```bash
cp terraform.tfvars.example terraform.tfvars
terraform init
terraform plan
terraform apply
```
