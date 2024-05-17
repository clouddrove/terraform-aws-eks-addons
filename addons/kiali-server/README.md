# Kiali Server Helm Chart

## Installation
Below terraform script shows how to use Kiali-Server Terraform Addon, A complete example is also given [here](https://github.com/clouddrove/terraform-helm-eks-addons/blob/master/_examples/complete/main.tf).
```hcl
module "addons" {
  source  = "clouddrove/eks-addons/aws"
  
  depends_on       = [module.eks.cluster_id]
  eks_cluster_name = module.eks.cluster_name

  kiali_server    = true
  kiali_manifests = var.kiali_manifests
}
```

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0.0 |
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
| <a name="module_helm_addon"></a> [helm\_addon](#module\_helm\_addon) | ../helm | n/a |

## Resources

| Name | Type |
|------|------|
| [kubectl_manifest.kiali_token](https://registry.terraform.io/providers/gavinbunney/kubectl/latest/docs/resources/manifest) | resource |
| [kubectl_manifest.kiali_virtualservice](https://registry.terraform.io/providers/gavinbunney/kubectl/latest/docs/resources/manifest) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_addon_context"></a> [addon\_context](#input\_addon\_context) | Input configuration for the addon | <pre>object({<br>    aws_caller_identity_account_id = string<br>    aws_caller_identity_arn        = string<br>    aws_eks_cluster_endpoint       = string<br>    aws_partition_id               = string<br>    aws_region_name                = string<br>    eks_cluster_id                 = string<br>    eks_oidc_issuer_url            = string<br>    eks_oidc_provider_arn          = string<br>    tags                           = map(string)<br>  })</pre> | n/a | yes |
| <a name="input_helm_config"></a> [helm\_config](#input\_helm\_config) | Helm provider config for Metrics Server | `any` | `{}` | no |
| <a name="input_kiali_manifests"></a> [kiali\_manifests](#input\_kiali\_manifests) | n/a | <pre>object({<br>    kiali_virtualservice_file_path = string<br>  })</pre> | n/a | yes |
| <a name="input_kiali_server_extra_configs"></a> [kiali\_server\_extra\_configs](#input\_kiali\_server\_extra\_configs) | Override attributes of helm\_release terraform resource | `any` | `{}` | no |
| <a name="input_manage_via_gitops"></a> [manage\_via\_gitops](#input\_manage\_via\_gitops) | Determines if the add-on should be managed via GitOps | `bool` | `false` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_chart_version"></a> [chart\_version](#output\_chart\_version) | n/a |
| <a name="output_namespace"></a> [namespace](#output\_namespace) | n/a |
| <a name="output_repository"></a> [repository](#output\_repository) | n/a |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## Additional Configurations
- To make Kiali Dashboard work you need to install `istio-ingress` & `aws-load-balancer-controller` addons.
- Kiali Server will be running behind istio-ingress. While using istio-ingress we have to create VirtualService to expose our application. A sample virtual-service.yaml is given [here](https://github.com/clouddrove/terraform-helm-eks-addons/blob/master/addons/kiali-server/config/kiali_vs.yaml)

- Get Kiali Dashboard login password via command
  ```bash
  kubectl get secret kiali-token -n istio-system -o jsonpath={.data.token} | base64 -d
  ```