# Velero Helm Chart

Velero is an open source tool to safely backup and restore, perform disaster recovery, and migrate Kubernetes cluster resources and persistent volumes.


## Installation
Below terraform script shows how to use Velero Terraform Addon, A complete example is also given [here](https://github.com/clouddrove/terraform-helm-eks-addons/blob/master/_examples/complete/main.tf).

```bash
module "addons" {
  source  = "clouddrove/eks-addons/aws"
  version = "0.0.6"
  
  depends_on       = [module.eks]
  eks_cluster_name = module.eks.cluster_name

  velero             = true
  velero_helm_config = { values = ["${file("./path/to/override-velero.yaml")}"] }
}
```

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
