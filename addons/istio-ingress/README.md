# Istio Helm Chart

Istio is a service mesh—a modernized service networking layer that provides a transparent and language-independent way to flexibly and easily automate application network functions. It is a popular solution for managing the different microservices that make up a cloud-native application. Istio service mesh also supports how those microservices communicate and share data with one another.

## Installation
Below terraform script shows how to use Istio-Ingress Terraform Addon, A complete example is also given [here](https://github.com/clouddrove/terraform-helm-eks-addons/blob/master/_examples/complete/main.tf).
```hcl
module "addons" {
  source  = "clouddrove/eks-addons/aws"
  version = "0.0.1"
  
  depends_on       = [module.eks.cluster_id]
  eks_cluster_name = module.eks.cluster_name

  istio_ingress    = true
}
```

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 3.72 |
| <a name="requirement_helm"></a> [helm](#requirement\_helm) | >= 2.6 |
| <a name="requirement_kubectl"></a> [kubectl](#requirement\_kubectl) | >= 1.7.0 |
| <a name="requirement_kubernetes"></a> [kubernetes](#requirement\_kubernetes) | >= 2.10 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_kubectl"></a> [kubectl](#provider\_kubectl) | >= 1.7.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_istio_base"></a> [istio\_base](#module\_istio\_base) | ../helm | n/a |
| <a name="module_istio_ingress"></a> [istio\_ingress](#module\_istio\_ingress) | ../helm | n/a |
| <a name="module_istiod"></a> [istiod](#module\_istiod) | ../helm | n/a |

## Resources

| Name | Type |
|------|------|
| [kubectl_manifest.istio_gateway_manifest](https://registry.terraform.io/providers/gavinbunney/kubectl/latest/docs/resources/manifest) | resource |
| [kubectl_manifest.istio_ingress_manifest](https://registry.terraform.io/providers/gavinbunney/kubectl/latest/docs/resources/manifest) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_addon_context"></a> [addon\_context](#input\_addon\_context) | Input configuration for the addon | <pre>object({<br/>    aws_caller_identity_account_id = string<br/>    aws_caller_identity_arn        = string<br/>    aws_eks_cluster_endpoint       = string<br/>    aws_partition_id               = string<br/>    aws_region_name                = string<br/>    eks_cluster_id                 = string<br/>    eks_oidc_issuer_url            = string<br/>    eks_oidc_provider_arn          = string<br/>    tags                           = map(string)<br/>  })</pre> | n/a | yes |
| <a name="input_helm_config"></a> [helm\_config](#input\_helm\_config) | Helm provider config for Istio Ingress | `any` | `{}` | no |
| <a name="input_istio_ingress_extra_configs"></a> [istio\_ingress\_extra\_configs](#input\_istio\_ingress\_extra\_configs) | Override attributes of helm\_release terraform resource | `any` | `{}` | no |
| <a name="input_istio_manifests"></a> [istio\_manifests](#input\_istio\_manifests) | n/a | <pre>object({<br/>    istio_ingress_manifest_file_path = list(any)<br/>    istio_gateway_manifest_file_path = list(any)<br/>  })</pre> | n/a | yes |
| <a name="input_istiod_helm_config"></a> [istiod\_helm\_config](#input\_istiod\_helm\_config) | Path to override-values.yaml for Istiod Helm Chart | `any` | `null` | no |
| <a name="input_manage_via_gitops"></a> [manage\_via\_gitops](#input\_manage\_via\_gitops) | Determines if the add-on should be managed via GitOps | `bool` | `false` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_chart_version"></a> [chart\_version](#output\_chart\_version) | n/a |
| <a name="output_namespace"></a> [namespace](#output\_namespace) | n/a |
| <a name="output_repository"></a> [repository](#output\_repository) | n/a |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
