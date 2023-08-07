# terraform-helm-eks-addons

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 4.23 |

## Providers

| Name | Version |
|------|---------|
| aws | >= 4.23 |
| kubernetes | >= 2.13 |
| helm | >= 2.6 |
| kubectl | >= 1.7.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_k8s_addons"></a> [k8s\_addons](#module\_k8s\_addons) | ./addons/helm | 0.0.1 |

## Resources

| Name | Use |
|------|-----|
|helm_release| A terraform resource to deploy helm charts on kubernetes cluster |

## Inputs

| Name | Description | Default | Required |
|------|-------------|---------|:--------:|
|metrics_server| To install metrics-server helmchart on eks cluster | False | Yes |
|metrics_server_helm_config | option to provide path to override-values.yaml | {values = "addons/metrics-server/config/metrics_server.yaml"} | No |
|cluster_autoscaler| To install cluster-autoscaler helmchart on eks cluster | False | Yes |
|cluster_autoscaler_helm_config | option to provide path to override-values.yaml | {values = "addons/cluster-autoscaler/config/cluster_autoscaler.yaml"} | No |
|aws_load_balancer_controller| To install aws-load-balancer-controller helmchart on eks cluster | False | Yes |
|aws_load_balancer_controller_helm_config | option to provide path to override-values.yaml | {values = "addons/aws-load-balancer-controller/config/aws_load_balancer_controller.yaml"} | No |
|aws_node_termination_handler| To install aws-node-termination-handler helmchart on eks cluster | False | Yes |
|aws_node_termination_handler_helm_config | option to provide path to override-values.yaml | {values = "addons/aws-node-termination-handler/config/aws_node_termination_handler.yaml"} | No |
|aws_efs_csi_driver| To install aws-efs-csi-driver helmchart on eks cluster | False | Yes |
|aws_efs_csi_driver_helm_config | option to provide path to override-values.yaml | {values = "addons/aws-efs-csi-driver/config/aws_efs_csi_driver.yaml"} | No |
|aws_ebs_csi_driver| To install aws-ebs-csi-driver helmchart on eks cluster | False | Yes |
|aws_ebs_csi_driver_helm_config | option to provide path to override-values.yaml | {values = "addons/aws-ebs-csi-driver/config/aws_ebs_csi_driver.yaml"} | No |
|karpenter| To install karpenter helmchart on eks cluster | False | Yes |
|karpenter_helm_config | option to provide path to override-values.yaml | {values = "addons/karpenter/config/karpenter.yaml"} | No |
|calico_tigera| To install Calico helmchart on eks cluster | False | Yes |
|calico_tigera_helm_config | option to provide path to override-values.yaml | {values = "addons/calico-tigera/config/calico-tigera-values.yaml"} | No |
|istio_ingress| To install Istio-ingress helmchart on eks cluster | False | Yes |
|istio_manifests| Kubernetes yaml manifests to create `ingress` and `gateway` with specified `host` | addons/istio-ingress/config/manifest/*.yaml | Yes |
|istio_ingress_helm_config | option to provide path to override-values.yaml | {values = "addons/istio-ingress/config/override-values.yaml"} | No |
|kiali_server| To install Kiali Dashboard helmchart on eks cluster | False | Yes |
|kiali_manifests| Includes VirtualService manifest file path and flag to install prometheus, grafana & jaeger | kiali_manifests { <br/>kiali_virtualservice_file_path = addons/kiali-server/config/kiali_vs.yaml <br> enable_monitoring = true <br/>}| Yes |
|kiali_server_helm_config | option to provide path to override-values.yaml | {values = "addons/kiali-server/config/kiali_server.yaml"} | No |


## Outputs

No outputs.

## How to Use

- A complete documentation to use `Calico` with AWS EKS is present [here](https://docs.aws.amazon.com/eks/latest/userguide/calico.html)
- An example of usage is given [here](https://github.com/clouddrove/terraform-helm-eks-addons/blob/master/_examples/complete/main.tf#L190-L232) and below also.

- Use below terraform module in your infrastructure's terraform script.

```bash
module "addons" {
  source  = "clouddrove/eks-addons/aws"
  version = "0.0.1"

  depends_on       = [module.eks.cluster_id]
  eks_cluster_name = module.eks.cluster_name

  metrics_server               = true
  cluster_autoscaler           = true
  aws_load_balancer_controller = true
  aws_node_termination_handler = true
  aws_efs_csi_driver           = true
  aws_ebs_csi_driver           = true

  kiali_server    = true
  kiali_manifests = var.kiali_manifests

  istio_ingress   = true
  istio_manifests = var.istio_manifests
}

```

## Known Issues

- ### Istio Ingress
  - Our `istio-ingress` addon creates an Application Load Balancer on AWS by using `aws-load-balancer-controller`. 
  - aws-load-balancer-controller adds a `finalizer` field in `ingress` resource to prevent its manual deletion.
  - Another case is that, this ingress will be **non-deletable** if aws-load-balancer-controller gets deleted before deletion of ingress
  - Terraform does not controlls order of destructure which is sometimes causing `aws-load-balancer-controller` helmchart uninstallation before istio-ingress deletion. 
  - The same issue will come when an appliaction uses ingress of type ALB; In this case we need to delete `istio-ingress` & ALB of applications manually by following some extra steps as shown below.
    1. Set `istio_ingress` to `false` in your terraform addon module.
    2. Run `terraform apply`, this will delete all the resource created by istio-ingress addon including istio-load-balancer.
    3. To delete ingress created by application run below command
       ```bash
        kubectl patch ingress ingressName -n namespace -p '{"metadata":{"finalizers":[]}}' --type=merge
       ```
    4. Now you can run `terraform destroy` for complete destruction.

- ### Calico CNI
  Our `calico-tigera` addon creates `trigera-operator` and `calico-node` out of which `calico-node` is being created using a manifest (calico-deployment.yaml). This manifest create two serviceAccounts (`calico-cni-plugin` & `calico-node`) which needs to be delete manually as shown below -
  1. Run `kubectl edit serviceAccount calico-cni-plugin -n calico-system` and delete `finalizer` block, then save and exit.
  2. Run `kubectl edit serviceAccount calico-node -n calico-system` and delete `finalizer` block, then save and exit.
  3. If both seriveAccount aren't deleted then run below command to delete them 
  ```bash
  kubectl delete seriveAccount calico-cni-plugin calico-node -n calico-system
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
