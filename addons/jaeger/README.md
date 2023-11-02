# Jaeger Agent Helm Chart

[Jaeger](https://www.jaegertracing.io/) is open source software for tracing transactions between distributed services. It's used for monitoring and troubleshooting complex microservices environments.

## Installation
Below terraform script shows how to use Jaeger Terraform Addon, A complete example is also given [here](https://github.com/clouddrove/terraform-helm-eks-addons/blob/master/_examples/complete/main.tf).
```hcl
module "addons" {
  source  = "clouddrove/eks-addons/aws"
  
  depends_on       = [module.eks.cluster_id]
  eks_cluster_name = module.eks.cluster_name

  jaeger             = true # Update the licence key before using this add-on from ./config/override-jaeger.yaml
  jaeger_helm_config = { values = [file("./config/override-jaeger.yaml")] }
}
```

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0.0 |
| <a name="requirement_kubernetes"></a> [kubernetes](#requirement\_kubernetes) | >= 2.10 |

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_cassandra"></a> [cassandra](#module\_cassandra) | ../helm | n/a |
| <a name="module_jaeger"></a> [jaeger](#module\_jaeger) | ../helm | n/a |
| <a name="module_kafka"></a> [kafka](#module\_kafka) | ../helm | n/a |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_addon_context"></a> [addon\_context](#input\_addon\_context) | Input configuration for the addon | <pre>object({<br>    aws_caller_identity_account_id = string<br>    aws_caller_identity_arn        = string<br>    aws_eks_cluster_endpoint       = string<br>    aws_partition_id               = string<br>    aws_region_name                = string<br>    eks_cluster_id                 = string<br>    eks_oidc_issuer_url            = string<br>    eks_oidc_provider_arn          = string<br>    tags                           = map(string)<br>  })</pre> | n/a | yes |
| <a name="input_cassandra_config"></a> [cassandra\_config](#input\_cassandra\_config) | Helm provider config for AWS Load Balancer Controller for cassandra | `any` | `{}` | no |
| <a name="input_cassandra_extra_configs"></a> [cassandra\_extra\_configs](#input\_cassandra\_extra\_configs) | Override attributes of helm\_release terraform resource for cassandra | `any` | `{}` | no |
| <a name="input_enable_kafka"></a> [enable\_kafka](#input\_enable\_kafka) | Whether to create kafka dependency or not. | `bool` | `false` | no |
| <a name="input_helm_config"></a> [helm\_config](#input\_helm\_config) | Helm provider config for AWS Load Balancer Controller for jaeger | `any` | `{}` | no |
| <a name="input_jaeger_extra_configs"></a> [jaeger\_extra\_configs](#input\_jaeger\_extra\_configs) | Override attributes of helm\_release terraform resource for jaeger | `any` | `{}` | no |
| <a name="input_kafka_config"></a> [kafka\_config](#input\_kafka\_config) | Helm provider config for AWS Load Balancer Controller for kafka | `any` | `{}` | no |
| <a name="input_kafka_extra_configs"></a> [kafka\_extra\_configs](#input\_kafka\_extra\_configs) | Override attributes of helm\_release terraform resource for kafka | `any` | `{}` | no |
| <a name="input_manage_via_gitops"></a> [manage\_via\_gitops](#input\_manage\_via\_gitops) | Determines if the add-on should be managed via GitOps | `bool` | `false` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_chart_version"></a> [chart\_version](#output\_chart\_version) | n/a |
| <a name="output_namespace"></a> [namespace](#output\_namespace) | n/a |
| <a name="output_repository"></a> [repository](#output\_repository) | n/a |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->