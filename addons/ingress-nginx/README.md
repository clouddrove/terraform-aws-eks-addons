# Ingress Nginx Helm Chart

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
ingress-nginx is an Ingress controller for Kubernetes using NGINX as a reverse proxy and load balancer.

## Installation
Below terraform script shows how to use Ingress Nginx Terraform Addon, A complete example is also given [here](https://github.com/clouddrove/terraform-helm-eks-addons/blob/master/_examples/complete/main.tf).

- By default it will create 2 network load balancers 1 is internal type and 1 is internet facing type.
user can change this behaviour according to their need. They just have to change values in `/_example/complete/config/override-ingress-nginx.yaml` file. User can also add annotations according to their need or they can add their own config file by the same name.

- if user wants to change `namespace`, `chart version`, `timeout`, `atomic`  and other helm artributes, A complete list of artributes is also given here [here](https://github.com/clouddrove/terraform-aws-eks-addons/blob/master/addons/helm/main.tf#L3-L32). then they can change this in `/_example/complate/variable.tf` at 
```bash
#--------------INGRESS NGINX------------
variable "nginx_ingress_extra_configs" {
  type = any
  default = {}
}
``` 

```bash
module "addons" {
  source = "../../"
  depends_on       = [null_resource.kubectl]
  eks_cluster_name = module.eks.cluster_name

   ingress_nginx                  = true
   nginx_ingress_extra_configs    = var.nginx_ingress_extra_configs
   ingress_nginx_helm_config      = { values = ["${file("./config/override-ingress-nginx.yaml")}"] }
}
```


## Inputs

| Name | Description | Default | Required |
|------|-------------|---------|:--------:|
| eks_cluster_name | Name of Kubernetes Cluster in which you want to install Ingress Nginx |  | Yes |
| ingress_nginx | To install  Ingress-Nginx helmchart set this to true | false | Yes |
| ingress_nginx_helm_config | Provide path to override-values.yaml of ingress_nginx | { values = ["${file("./config/override-ingress-nginx.yaml")}"] } | No |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
