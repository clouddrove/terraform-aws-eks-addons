# Grafana Agent Helm Chart

[Grafana](https://grafana.com/)is open source visualization and analytics software. It allows you to query, visualize, alert on, and explore your metrics no matter where they are stored. In plain English, it provides you with tools to turn your time-series database (TSDB) data into beautiful graphs and visualizations.

## Installation
Below terraform script shows how to use Grafana Terraform Addon, A complete example is also given [here](https://github.com/clouddrove/terraform-helm-eks-addons/blob/master/_examples/complete/main.tf).
```hcl
module "addons" {
  source  = "clouddrove/eks-addons/aws"
  
  depends_on       = [module.eks.cluster_id]
  eks_cluster_name = module.eks.cluster_name

  grafana             = true # Update the licence key before using this add-on from ./config/override-grafana.yaml
  grafana_helm_config = { values = ["${file("./config/override-grafana.yaml")}"] }
}
```

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->