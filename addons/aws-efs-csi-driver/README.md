# AWS EFS CSI Driver Helm Chart

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

The [Amazon Elastic File System](https://aws.amazon.com/efs/) Container Storage Interface (CSI) Driver implements the [CSI](https://github.com/container-storage-interface/spec/blob/master/spec.md) specification for container orchestrators to manage the lifecycle of Amazon EFS file systems.

Amazon EFS CSI driver supports dynamic provisioning and static provisioning. Currently, Dynamic Provisioning creates an access point for each PV. This mean an Amazon EFS file system has to be created manually on AWS first and should be provided as an input to the storage class parameter. For static provisioning, the Amazon EFS file system needs to be created manually on AWS first. After that, it can be mounted inside a container as a volume using the driver.

## Installation
Below terraform script shows how to use AWS EFS CSI Driver Terraform Addon, A complete example is also given [here](https://github.com/clouddrove/terraform-helm-eks-addons/blob/master/_examples/complete/main.tf).
```bash
module "addons" {
  source  = "clouddrove/eks-addons/aws"
  version = "0.0.1"
  
  depends_on       = [module.eks.cluster_id]
  eks_cluster_name = module.eks.cluster_name

  aws_efs_csi_driver = true
}
```


## Inputs

| Name | Description | Default | Required |
|------|-------------|---------|:--------:|
| eks_cluster_name | Name of Kubernetes Cluster in which you want to install AWS EFS CSI Driver |  | Yes |
| aws_efs_csi_driver | Set this to **true** to install AWS EFS CSI Driver helmchart. | false | Yes |
| aws_efs_csi_driver_helm_config | Override [attributes](https://github.com/clouddrove/terraform-helm-eks-addons/blob/master/addons/helm/main.tf#L1-L33) of helm_release terraform resource. | `name`, `chart`, `repository`, `version`, `namespace`,`description` are can not be override | No |


<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
