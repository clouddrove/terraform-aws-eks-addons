# Istio Helm Chart

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
Istio is a service mesh—a modernized service networking layer that provides a transparent and language-independent way to flexibly and easily automate application network functions. It is a popular solution for managing the different microservices that make up a cloud-native application. Istio service mesh also supports how those microservices communicate and share data with one another.

## Installation
Below terraform script shows how to use Istio-Ingress Terraform Addon, A complete example is also given [here](https://github.com/clouddrove/terraform-helm-eks-addons/blob/master/_examples/complete/main.tf).
```bash
module "addons" {
  source  = "clouddrove/eks-addons/aws"
  version = "0.0.1"
  
  depends_on       = [module.eks.cluster_id]
  eks_cluster_name = module.eks.cluster_name

  istio_ingress    = true
}
```


## Inputs

| Name | Description | Default | Required |
|------|-------------|---------|:--------:|
| eks_cluster_name | Name of Kubernetes Cluster in which you want to install Istio |  | Yes |
| istio_ingress | Set this to **true** to install Istio helmchart. | false | Yes |
| istio_ingress_helm_config | Provide path to override-values.yaml of istio_ingress | { values = ["${file("./config/istio/override-values.yaml")}"] } | No |
| istio_ingress_manifest_file_path | path to Ingress manifest | n/a | Yes |
| istio_gateway_manifest_file_path | path to Gateway manifest | n/a | Yes |

An example of manifests files are given [here](https://github.com/clouddrove/terraform-helm-eks-addons/tree/master/addons/istio-ingress/config/manifest/)

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
