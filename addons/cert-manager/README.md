# Certification Manager Helm Chart

Certification Manager is a Kubernetes addon to automate the management and issuance of TLS certificates from various issuing sources.
It will ensure certificates are valid and up to date periodically, and attempt to renew certificates at an appropriate time before expiry..

## Installation
Below terraform script shows how to use Certification Manager Terraform Addon, A complete example is also given [here](https://github.com/clouddrove/terraform-helm-eks-addons/blob/master/_examples/complete/main.tf).
```hcl
module "addons" {
  source  = "clouddrove/eks-addons/aws"
  version = "0.1.0"
  
  depends_on       = [module.eks]
  eks_cluster_name = module.eks.cluster_name

  certification_manager   = true
}
```

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0.0 |
| <a name="requirement_kubernetes"></a> [kubernetes](#requirement\_kubernetes) | >= 2.10 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_helm_addon"></a> [helm\_addon](#module\_helm\_addon) | ../helm | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_iam_policy.policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_eks_cluster.eks_cluster](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/eks_cluster) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_account_id"></a> [account\_id](#input\_account\_id) | n/a | `string` | `""` | no |
| <a name="input_addon_context"></a> [addon\_context](#input\_addon\_context) | Input configuration for the addon | <pre>object({<br/>    aws_caller_identity_account_id = string<br/>    aws_caller_identity_arn        = string<br/>    aws_eks_cluster_endpoint       = string<br/>    aws_partition_id               = string<br/>    aws_region_name                = string<br/>    eks_cluster_id                 = string<br/>    eks_oidc_issuer_url            = string<br/>    eks_oidc_provider_arn          = string<br/>    tags                           = map(string)<br/>  })</pre> | n/a | yes |
| <a name="input_certification_manager_extra_configs"></a> [certification\_manager\_extra\_configs](#input\_certification\_manager\_extra\_configs) | Override attributes of helm\_release terraform resource | `any` | `{}` | no |
| <a name="input_eks_cluster_name"></a> [eks\_cluster\_name](#input\_eks\_cluster\_name) | n/a | `string` | `""` | no |
| <a name="input_helm_config"></a> [helm\_config](#input\_helm\_config) | Helm provider config for Certification Manager | `any` | `{}` | no |
| <a name="input_iampolicy_json_content"></a> [iampolicy\_json\_content](#input\_iampolicy\_json\_content) | Custom IAM Policy for cert manager IRSA | `string` | `null` | no |
| <a name="input_manage_via_gitops"></a> [manage\_via\_gitops](#input\_manage\_via\_gitops) | Determines if the add-on should be managed via GitOps | `bool` | `false` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_chart_version"></a> [chart\_version](#output\_chart\_version) | n/a |
| <a name="output_namespace"></a> [namespace](#output\_namespace) | n/a |
| <a name="output_repository"></a> [repository](#output\_repository) | n/a |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
