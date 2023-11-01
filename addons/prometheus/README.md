# Prometheus Agent Helm Chart

[Prometheus](https://prometheus.io/docs/introduction/overview/) offers an open-source monitoring and alerting toolkit designed especially for microservices and containers. Prometheus monitoring lets you run flexible queries and configure real-time notifications.

## Installation
Below terraform script shows how to use Prometheus Terraform Addon, A complete example is also given [here](https://github.com/clouddrove/terraform-helm-eks-addons/blob/master/_examples/complete/main.tf).
```hcl
module "addons" {
  source  = "clouddrove/eks-addons/aws"
  
  depends_on       = [module.eks.cluster_id]
  eks_cluster_name = module.eks.cluster_name

  prometheus             = true # Update the licence key before using this add-on from ./config/override-prometheus.yaml
  prometheus_helm_config = { values = ["${file("./config/override-prometheus.yaml")}"] }
}
```

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->