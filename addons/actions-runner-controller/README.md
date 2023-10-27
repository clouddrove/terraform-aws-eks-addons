# Actions Runner Controller Helm Chart

Actions Runner Controller is a Kubernetes addon to automate the management and issuance of TLS certificates from various issuing sources.
It will ensure certificates are valid and up to date periodically, and attempt to renew certificates at an appropriate time before expiry..

## Installation
Below terraform script shows how to use Actions Runner Controller Terraform Addon, A complete example is also given [here](https://github.com/clouddrove/terraform-helm-eks-addons/blob/master/_examples/complete/main.tf).
```hcl
module "addons" {
  source  = "clouddrove/eks-addons/aws"
  version = "0.1.2"
  
  depends_on       = [module.eks]
  eks_cluster_name = module.eks.cluster_name

  actions_runner_controller   = true
}
```
## Prerequisite

Before you begin, make sure you have the following:

### Authentication for Self-Hosted Runners
Access to a GitHub repository for creating PAT and adding runners.

There are two ways for the actions-runner-controller to authenticate with the GitHub API (only 1 can be configured at a time, however)

Using a GitHub App (not supported for enterprise-level runners due to lack of support from GitHub)
Using a PAT(Personal Access Token) 
1. Using CLI:
   `kubectl create secret generic controller-manager1 -n actions-runner-system --from-literal=github_token=XXXXXX`
2. pass secrets in override-actions-runner-controller.yaml
### Cert Manager on K8s cluster
Installing Cert Manager on K8s cluster.
Well, actions-runner-controller(ACR) uses cert-manager for certificate management of admission webhook, so we have to ensure cert-manager is installed on Kubernetes before installing actions-runner-controller.
Refer to this link for Cert Manager Installation via Helm
certification manager [here(https://artifacthub.io/packages/helm/cert-manager/cert-manager) also you can refere our addon module

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0.0 |
| <a name="requirement_kubernetes"></a> [kubernetes](#requirement\_kubernetes) | >= 2.10 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_kubernetes"></a> [kubernetes](#provider\_kubernetes) | >= 2.10 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_helm_addon"></a> [helm\_addon](#module\_helm\_addon) | ../helm | n/a |

## Resources

| Name | Type |
|------|------|
| [kubernetes_namespace_v1.this](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/namespace_v1) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_addon_context"></a> [addon\_context](#input\_addon\_context) | Input configuration for the addon | <pre>object({<br>    aws_caller_identity_account_id = string<br>    aws_caller_identity_arn        = string<br>    aws_eks_cluster_endpoint       = string<br>    aws_partition_id               = string<br>    aws_region_name                = string<br>    eks_cluster_id                 = string<br>    eks_oidc_issuer_url            = string<br>    eks_oidc_provider_arn          = string<br>    tags                           = map(string)<br>  })</pre> | n/a | yes |
| <a name="input_helm_config"></a> [helm\_config](#input\_helm\_config) | Helm provider config for Actions Runner Controller | `any` | `{}` | no |
| <a name="input_manage_via_gitops"></a> [manage\_via\_gitops](#input\_manage\_via\_gitops) | Determines if the add-on should be managed via GitOps | `bool` | `false` | no |
| <a name="input_actions_runner_controller_extra_configs"></a> [actions_runner_controller\_extra\_configs](#input\actions_runner_controller\_extra\_configs) | Override attributes of helm\_release terraform resource | `any` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_chart_version"></a> [chart\_version](#output\_chart\_version) | n/a |
| <a name="output_namespace"></a> [namespace](#output\_namespace) | n/a |
| <a name="output_repository"></a> [repository](#output\_repository) | n/a |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
