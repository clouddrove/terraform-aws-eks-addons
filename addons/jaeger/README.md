# Jaeger Agent Helm Chart

[Jaeger](https://www.jaegertracing.io/) is open source software for tracing transactions between distributed services. It's used for monitoring and troubleshooting complex microservices environments.

## Installation
Below terraform script shows how to use Jaeger Terraform Addon, A complete example is also given [here](https://github.com/clouddrove/terraform-helm-eks-addons/blob/master/_examples/complete/main.tf).
```hcl
module "addons" {
  source  = "clouddrove/eks-addons/aws"
  
  depends_on       = [module.eks.cluster_id]
  eks_cluster_name = module.eks.cluster_name

  jaeger             = true # Update the licence key before using this add-on from ./config/override-jaeger.yaml
  jaeger_helm_config = { values = [file("./config/override-jaeger.yaml")] }
}
```

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->