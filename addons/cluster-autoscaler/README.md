# Cluster Autoscaler Helm Chart

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
Cluster Autoscaler is a tool that automatically adjusts the size of the Kubernetes cluster when one of the following conditions is true:
- there are pods that failed to run in the cluster due to insufficient resources.
- there are nodes in the cluster that have been underutilized for an extended period of time and their pods can be placed on other existing nodes.

## Installation
Below terraform script shows how to use Cluster Autoscaler Terraform Addon, A complete example is also given [here](https://github.com/clouddrove/terraform-helm-eks-addons/blob/master/_examples/complete/main.tf).
```bash
module "addons" {
  source = "../../"
  depends_on       = [null_resource.kubectl]
  eks_cluster_name = module.eks.cluster_name

  cluster_autoscaler = true
}
```


## Inputs

| Name | Description | Default | Required |
|------|-------------|---------|:--------:|
| eks_cluster_name | Name of Kubernetes Cluster in which you want to install Cluster Autoscaler |  | Yes |
| cluster_autoscaler | Set this to **true** to install Cluster Autoscaler helmchart. | false | Yes |
| cluster_autoscaler_helm_config | Override [attributes](https://github.com/clouddrove/terraform-helm-eks-addons/blob/master/addons/helm/main.tf#L1-L33) of helm_release terraform resource. | `name`, `chart`, `repository`, `version`, `namespace`,`description` are can not be override | No |


<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
