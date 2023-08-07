# Karpenter Helm Chart

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
Karpenter simplifies Kubernetes infrastructure with the right nodes at the right time. Karpenter automatically launches just the right compute resources to handle your cluster's applications. It is designed to let you take full advantage of the cloud with fast and simple compute provisioning for Kubernetes clusters.

## Installation
Below terraform script shows how to use Karpenter Terraform Addon, A complete example is also given [here](https://github.com/clouddrove/terraform-helm-eks-addons/blob/master/_examples/complete/main.tf).
```bash
module "addons" {
  source  = "clouddrove/eks-addons/aws"
  version = "0.0.1"
  
  depends_on       = [module.eks.cluster_id]
  eks_cluster_name = module.eks.cluster_name

  karpenter        = true
}
```


## Inputs

| Name | Description | Default | Required |
|------|-------------|---------|:--------:|
| eks_cluster_name | Name of Kubernetes Cluster in which you want to install karpenter |  | Yes |
| karpenter | Set this to **true** to install karpenter helmchart. | false | Yes |
| karpenter_helm_config | Override [attributes](https://github.com/clouddrove/terraform-helm-eks-addons/blob/master/addons/helm/main.tf#L1-L33) of helm_release terraform resource. | `name`, `chart`, `repository`, `version`, `namespace`,`description` are can not be override | No |


<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
