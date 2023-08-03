# Ingress Nginx Helm Chart

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
ingress-nginx is an Ingress controller for Kubernetes using NGINX as a reverse proxy and load balancer.

## Installation
Below terraform script shows how to use Ingress Nginx Terraform Addon, A complete example is also given [here](https://github.com/clouddrove/terraform-helm-eks-addons/blob/master/_examples/complete/main.tf).

Note : By default it will create 2 network load balancers 1 is internal type and 1 is internet facing type.
You can change this behaviour according to your need. You just have to change values in _example/complete/config/override-ingress-nginx.yaml file. You can also add annotations according to your need or you can add your own config file by the same name.

```bash
module "addons" {
  source = "../../"
  depends_on       = [null_resource.kubectl]
  eks_cluster_name = module.eks.cluster_name

   ingress_nginx                  = true
   ingress_nginx_helm_config      = {values = ["${file("./config/override-ingress-nginx.yaml")}"]}
}
```


## Inputs

| Name | Description | Default | Required |
|------|-------------|---------|:--------:|
| eks_cluster_name | Name of Kubernetes Cluster in which you want to install Ingress Nginx |  | Yes |
|  ingress_nginx | To install  Ingress-Nginx helmchart set this to true | false | Yes |
|  ingress_nginx_helm_config | Override [attributes](https://github.com/clouddrove/terraform-helm-eks-addons/blob/master/addons/helm/main.tf#L1-L33) of helm_release terraform resource. | `name`, `chart`, `repository`, `version`, `namespace`,`description` are can not be override | No |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->