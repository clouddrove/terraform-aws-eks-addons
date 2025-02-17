# Ingress Nginx Helm Chart

ingress-nginx is an Ingress controller for Kubernetes using NGINX as a reverse proxy and load balancer.

## Installation
Below terraform script shows how to use Ingress Nginx Terraform Addon, A complete example is also given [here](https://github.com/clouddrove/terraform-helm-eks-addons/blob/master/_examples/complete/main.tf).

- By default it will create 2 network load balancers 1 is internal type and 1 is internet facing type.
user can change this behaviour according to their need. They just have to change values in `/_example/complete/config/override-ingress-nginx.yaml` file. User can also add annotations according to their need or they can add their own config file by the same name.

- if user wants to change `namespace`, `chart version`, `timeout`, `atomic`  and other helm artributes, A complete list of artributes is also given here [here](https://github.com/clouddrove/terraform-aws-eks-addons/blob/master/addons/helm/main.tf#L3-L32). then they can change this in `/_example/complate/variable.tf` at 
```hcl
#--------------INGRESS NGINX------------
variable "ingress_nginx_extra_configs" {
  type = any
  default = {}
}
``` 

```hcl
module "addons" {
  source = "../../"
  depends_on       = [null_resource.kubectl]
  eks_cluster_name = module.eks.cluster_name

   ingress_nginx                  = true
   ingress_nginx_extra_configs    = var.ingress_nginx_extra_configs
   ingress_nginx_helm_config      = { values = ["${file("./config/override-ingress-nginx.yaml")}"] }
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
| <a name="module_helm_addon"></a> [helm\_addon](#module\_helm\_addon) | ../helm | n/a |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_addon_context"></a> [addon\_context](#input\_addon\_context) | Input configuration for the addon | <pre>object({<br/>    aws_caller_identity_account_id = string<br/>    aws_caller_identity_arn        = string<br/>    aws_eks_cluster_endpoint       = string<br/>    aws_partition_id               = string<br/>    aws_region_name                = string<br/>    eks_cluster_id                 = string<br/>    eks_oidc_issuer_url            = string<br/>    eks_oidc_provider_arn          = string<br/>    tags                           = map(string)<br/>  })</pre> | n/a | yes |
| <a name="input_helm_config"></a> [helm\_config](#input\_helm\_config) | Helm provider config for Nginx Ingress | `any` | `{}` | no |
| <a name="input_ingress_nginx_extra_configs"></a> [ingress\_nginx\_extra\_configs](#input\_ingress\_nginx\_extra\_configs) | Nginx ingress extra config | `any` | `{}` | no |
| <a name="input_manage_via_gitops"></a> [manage\_via\_gitops](#input\_manage\_via\_gitops) | Determines if the add-on should be managed via GitOps | `bool` | `false` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_chart_version"></a> [chart\_version](#output\_chart\_version) | n/a |
| <a name="output_namespace"></a> [namespace](#output\_namespace) | n/a |
| <a name="output_repository"></a> [repository](#output\_repository) | n/a |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
