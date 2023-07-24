# K8s Pod Restart Info Collector Helm Chart

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
k8s-pod-restart-info-collector is a simple K8s customer controller that watches for Pods changes and collects K8s Pod restart reasons, logs, and events to Slack channel when a Pod restarts.

## Installation
Below terraform script shows how to use K8s Pod Restart Info Collector Terraform Addon, A complete example is also given [here](https://github.com/clouddrove/terraform-helm-eks-addons/blob/master/_examples/complete/main.tf).
```bash
module "addons" {
  source = "../../"
  depends_on       = [null_resource.kubectl]
  eks_cluster_name = module.eks.cluster_name

  k8s_pod_restart_info_collector        = true
  slack_config = {
    slack_webhook_url = var.slack_config.slack_webhook_url
    slack_channel     = var.slack_config.slack_channel
  }
}
```


## Inputs

| Name | Description | Default | Required |
|------|-------------|---------|:--------:|
| eks_cluster_name | Name of Kubernetes Cluster in which you want to install k8s_pod_restart_info_collector |  | Yes |
| k8s_pod_restart_info_collector | Set this to **true** to install k8s_pod_restart_info_collector helmchart. | false | Yes |
| slack_webhook_url | Provide your slack channel webhook URL to receive notifications on slack |  | Yes
| slack_channel | Provide your slack chanel name in which you want to receive slack notifications |  | Yes


<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
