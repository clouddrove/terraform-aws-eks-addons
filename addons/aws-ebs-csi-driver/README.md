# AWS EBS CSI Driver Helm Chart

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

The [Amazon Elastic Block Store Container Storage](https://aws.amazon.com/ebs/) Interface (CSI) Driver provides a [CSI](https://github.com/container-storage-interface/spec/blob/master/spec.md) interface used by Container Orchestrators to manage the lifecycle of Amazon EBS volumes.

## Installation
Below terraform script shows how to use AWS EBS CSI Driver Terraform Addon, A complete example is also given [here](https://github.com/clouddrove/terraform-helm-eks-addons/blob/master/_examples/complete/main.tf).
```bash
module "addons" {
  source  = "clouddrove/eks-addons/aws"
  version = "0.0.1"
  
  depends_on       = [module.eks.cluster_id]
  eks_cluster_name = module.eks.cluster_name

  aws_ebs_csi_driver = true
}
```


## Inputs

| Name | Description | Default | Required |
|------|-------------|---------|:--------:|
| eks_cluster_name | Name of Kubernetes Cluster in which you want to install AWS EBS CSI Driver |  | Yes |
| aws_ebs_csi_driver | Set this to **true** to install AWS EBS CSI Driver helmchart. | false | Yes |
| aws_ebs_csi_driver_helm_config | Override [attributes](https://github.com/clouddrove/terraform-helm-eks-addons/blob/master/addons/helm/main.tf#L1-L33) of helm_release terraform resource. | `name`, `chart`, `repository`, `version`, `namespace`,`description` are can not be override | No |


<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
