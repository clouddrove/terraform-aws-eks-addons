# New-Relic Agent Helm Chart

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
A [New Relic agent](https://newrelic.com/) is a Software as a Service offering that focuses on performance and availability monitoring. It uses a standardized Apdex (application performance index) score to set and rate application performance across the environment in a unified manner.

## Installation
Below terraform script shows how to use New-Relic Terraform Addon, A complete example is also given [here](https://github.com/clouddrove/terraform-helm-eks-addons/blob/master/_examples/complete/main.tf).
```bash
module "addons" {
  source  = "clouddrove/eks-addons/aws"
  version = "0.0.1"
  
  depends_on       = [module.eks.cluster_id]
  eks_cluster_name = module.eks.cluster_name

  new_relic             = true # Update the licence key before using this add-on from ./config/override-new-relic.yaml
  new_relic_helm_config = { values = ["${file("./config/override-new-relic.yaml")}"] }
}
```

## Inputs

| Name | Description | Default | Required |
|------|-------------|---------|:--------:|
| eks_cluster_name | Name of Kubernetes Cluster in which you want to install New-Relic |  | Yes |
| new_relic | To install new-relic helmchart set this to true | false | Yes |
| new_relic_helm_config | Provide path to override-values.yaml of new_relic | { values = ["${file("./config/override-new-relic.yaml")}"] } | No |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->