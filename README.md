# terraform-helm-eks-addos

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 4.23 |
| <a name="requirement_helm"></a> [helm](#requirement\_helm) | >= 2.6 |
| <a name="requirement_kubernetes"></a> [kubernetes](#requirement\_kubernetes) | >= 2.13 |

## Providers

| Name |
|------|
| aws |
| kubernetes |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_k8s_addons"></a> [k8s\_addons](#module\_k8s\_addons) | ./addons/helm | n/a |

## Resources

| Resource Type | Name | Use |
|------|-----|---------|
|null_resource| kubectl | Connect to aws EKS cluster from terminal where the aws cli is configured |
Sample null_resource
```bash
resource "null_resource" "kubectl" {
  depends_on = [local_file.kubeconfig]
  provisioner "local-exec" {
    command = "export KUBE_CONFIG_PATH=${path.cwd}/config/kubeconfig && aws eks update-kubeconfig --name ${module.eks.cluster_name} --region ${local.region}"
  }
}
```

## Inputs

| Name | Description | Default | Required |
|------|-------------|---------|:--------:|
|enable_metrics_server| Set this to true to install metrics-server helmchart on eks cluster | False | Yes |
|enable_cluster_autoscaler| Set this to true to install cluster-autoscaler helmchart on eks cluster | False | Yes |
|enable_aws_load_balancer_controller| Set this to true to install aws-load-balancer-controller helmchart on eks cluster | False | Yes |
|enable_aws_node_termination_handler| Set this to true to install aws-node-termination-handler helmchart on eks cluster | False | Yes |
|enable_aws_efs_csi_driver| Set this to true to install aws-efs-csi-driver helmchart on eks cluster | False | Yes |
|metrics_server_helm_config | Flags for helm command | {values = "addons/addon-name/config/addon-name.yaml"} | No |
|cluster_autoscaler_helm_config | Flags for helm command | {values = "addons/addon-name/config/addon-name.yaml"} | No |
|aws_load_balancer_controller_helm_config | Flags for helm command | {values = "addons/addon-name/config/addon-name.yaml"} | No |
|aws_node_termination_handler_helm_config | Flags for helm command | {values = "addons/addon-name/config/addon-name.yaml"} | No |
|aws_efs_csi_driver_helm_config | Flags for helm command | {values = "addons/addon-name/config/addon-name.yaml"} | No |

- Availabel Flags for helm command are [here](https://github.com/clouddrove/terraform-helm-eks-addons/blob/master/addons/helm/main.tf#L2-L33).

## Outputs

No outputs.

## How to Use
An example of usage is given [here](https://github.com/clouddrove/terraform-helm-eks-addons/blob/master/_examples/complete/main.tf#L226-L254) and below also.
If you are running `terraform apply` from local then make sure to set `KUBE_CONFIG_PATH` as an environment variable with value `~/.kube/config` where aws cli is configured, i.e. `export KUBE_CONFIG_PATH=~/.kube/config`

```bash
resource "null_resource" "kubectl" {
  depends_on = [local_file.kubeconfig]
  provisioner "local-exec" {
    command = "aws eks update-kubeconfig --name my-eks-cluster --region us-east-1"
  }
}

module "addons" {
  source = "../../addons"
  depends_on = [null_resource.kubectl]

  eks_cluster_name = "my-eks-cluster"

  enable_metrics_server               = true
  enable_cluster_autoscaler           = true
  enable_aws_load_balancer_controller = true
  enable_aws_node_termination_handler = true
  enable_aws_efs_csi_driver           = true

}
```

## Feedback 
If you come accross a bug or have any feedback, please log it in our [issue tracker](https://github.com/clouddrove/terraform-helm-eks-addons/issues), or feel free to drop us an email at [hello@clouddrove.com](mailto:hello@clouddrove.com).

If you have found it worth your time, go ahead and give us a ★ on [our GitHub](https://github.com/clouddrove/terraform-helm-eks-addons)!

## About us

At [CloudDrove][website], we offer expert guidance, implementation support and services to help organisations accelerate their journey to the cloud. Our services include docker and container orchestration, cloud migration and adoption, infrastructure automation, application modernisation and remediation, and performance engineering.

<p align="center">We are <b> The Cloud Experts!</b></p>
<hr />
<p align="center">We ❤️  <a href="https://github.com/clouddrove">Open Source</a> and you can check out <a href="https://github.com/clouddrove">our other modules</a> to get help with your new Cloud ideas.</p>

  [website]: https://clouddrove.com
  [github]: https://github.com/clouddrove
  [linkedin]: https://cpco.io/linkedin
  [twitter]: https://twitter.com/clouddrove/
  [email]: https://clouddrove.com/contact-us.html
  [terraform_modules]: https://github.com/clouddrove?utf8=%E2%9C%93&q=terraform-&type=&language=

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
