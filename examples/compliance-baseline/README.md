# Compliance Baseline Example

Opinionated addons stack for SOC2/HIPAA-aligned technical baseline on an **existing EKS cluster**.

## Included addons
- Metrics Server
- Cluster Autoscaler
- AWS Load Balancer Controller
- AWS Node Termination Handler
- AWS EBS/EFS CSI Drivers
- Calico Tigera
- NGINX Ingress
- External Secrets
- cert-manager
- Fluent Bit
- kube-state-metrics
- Prometheus
- Velero
- Reloader

## Usage
```bash
cp terraform.tfvars.example terraform.tfvars
terraform init
terraform plan
terraform apply
```

> Note: This is not a compliance certification by itself; pair with your org control/evidence process.
