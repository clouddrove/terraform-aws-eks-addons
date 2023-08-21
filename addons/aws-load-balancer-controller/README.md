# AWS Load Balancer Controller Helm Chart

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

AWS Load Balancer controller manages the following AWS resources
- Application Load Balancers to satisfy Kubernetes ingress objects
- Network Load Balancers to satisfy Kubernetes service objects of type LoadBalancer with appropriate annotations

## Installation
Below terraform script shows how to use AWS Load Balancer Controller Terraform Addon, A complete example is also given [here](https://github.com/clouddrove/terraform-helm-eks-addons/blob/master/_examples/complete/main.tf).
```bash
module "addons" {
  source  = "clouddrove/eks-addons/aws"
  version = "0.0.1"
  
  depends_on       = [module.eks.cluster_id]
  eks_cluster_name = module.eks.cluster_name

  aws_load_balancer_controller = true
}
```


## Inputs

| Name | Description | Default | Required |
|------|-------------|---------|:--------:|
| eks_cluster_name | Name of Kubernetes Cluster in which you want to install AWS Load Balancer Controller |  | Yes |
| aws_load_balancer_controller | Set this to **true** to install AWS Load Balancer Controller helmchart. | false | Yes |
| aws_load_balancer_controller_helm_config | Provide path to override-values.yaml of aws_load_balancer_controller | { values = ["${file("./config/override-aws-load-balancer-controller.yaml")}"] } | No |


<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
