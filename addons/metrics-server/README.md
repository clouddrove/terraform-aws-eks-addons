# Metrics Server Helm Chart

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
Metrics Server collects resource metrics from Kubelets and exposes them in Kubernetes apiserver through [Metrics API](https://github.com/kubernetes/metrics) for use by [Horizontal Pod Autoscaler](https://kubernetes.io/docs/tasks/run-application/horizontal-pod-autoscale/) and [Vertical Pod Autoscaler](https://github.com/kubernetes/autoscaler/tree/master/vertical-pod-autoscaler/). Metrics API can also be accessed by `kubectl top`, making it easier to debug autoscaling pipelines.

## Installation
Below terraform script shows how to use Metrics-Server Terraform Addon, A complete example is also given [here](https://github.com/clouddrove/terraform-helm-eks-addons/blob/master/_examples/complete/main.tf).
```bash
module "addons" {
  source  = "clouddrove/eks-addons/aws"
  version = "0.0.1"
  
  depends_on       = [module.eks.cluster_id]
  eks_cluster_name = module.eks.cluster_name

  metrics_server   = true
}
```


## Inputs

| Name | Description | Default | Required |
|------|-------------|---------|:--------:|
| eks_cluster_name | Name of Kubernetes Cluster in which you want to install Metrics-Server |  | Yes |
| metrics_server | To install metrics-server helmchart set this to true | false | Yes |
| metrics_server_helm_config | Override [attributes](https://github.com/clouddrove/terraform-helm-eks-addons/blob/master/addons/helm/main.tf#L1-L33) of helm_release terraform resource. | `name`, `chart`, `repository`, `version`, `namespace`,`description` are can not be override | No |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
