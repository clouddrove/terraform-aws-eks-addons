# Cost Optimized Example

Opinionated addons stack for cost-aware operations on an **existing EKS cluster**.

## Included addons
- Metrics Server
- Cluster Autoscaler
- AWS Load Balancer Controller
- AWS Node Termination Handler
- AWS EBS CSI Driver
- NGINX Ingress
- KEDA
- External DNS
- Reloader

## Usage
```bash
cp terraform.tfvars.example terraform.tfvars
terraform init
terraform plan
terraform apply
```
