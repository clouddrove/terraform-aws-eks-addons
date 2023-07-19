# Istio Helm Chart

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
Istio is a service mesh—a modernized service networking layer that provides a transparent and language-independent way to flexibly and easily automate application network functions. It is a popular solution for managing the different microservices that make up a cloud-native application. Istio service mesh also supports how those microservices communicate and share data with one another.

## Installation
Below terraform script shows how to use Istio-Ingress Terraform Addon, A complete example is also given [here](https://github.com/clouddrove/terraform-helm-eks-addons/blob/master/_examples/complete/main.tf).
```bash
module "addons" {
  source = "../../"
  depends_on       = [null_resource.kubectl]
  eks_cluster_name = module.eks.cluster_name

  istio_ingress    = true
}
```


## Inputs

| Name | Description | Default | Required |
|------|-------------|---------|:--------:|
| eks_cluster_name | Name of Kubernetes Cluster in which you want to install Istio |  | Yes |
| istio_ingress | Set this to **true** to install Istio helmchart. | false | Yes |
| istio_ingress_helm_config | Override [attributes](https://github.com/clouddrove/terraform-helm-eks-addons/blob/master/addons/helm/main.tf#L1-L33) of helm_release terraform resource. | `name`, `chart`, `repository`, `version`, `namespace`,`description` are can not be override | No |
| istio_ingress_manifest_file_path | path to Ingress manifest | addons/istio-ingress/config/ingress.yaml | Yes |
| istio_gateway_manifest_file_path | path to Gateway manifest | addons/istio-ingress/config/gateway.yaml | Yes |
| istio_virtualservice_manifest | path to VirtualService manifest | addons/istio-ingress/config/virtual-service.yaml | Yes |


<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
