# FluentBit Helm Chart

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

Fluent Bit is a lightweight log processor and forwarder that you use to collect container logs in Amazon CloudWatch.

## Installation
Below terraform script shows how to use FluentBit Terraform Addon, A complete example is also given [here](https://github.com/clouddrove/terraform-helm-eks-addons/blob/master/_examples/complete/main.tf).
```bash
module "addons" {
  source  = "clouddrove/eks-addons/aws"
  version = "0.0.4"
  
  depends_on       = [module.eks.cluster_id]
  eks_cluster_name = module.eks.cluster_name

  fluent_bit               = true
}
```
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
