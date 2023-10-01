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

**To install any of the below listed addon in your EKS Cluster -**

| Name | Default | Required |
|------|---------|----------|
|metrics_server| False | No |
|cluster_autoscaler|False | No ||
|aws_load_balancer_controller|False | No |cluster | False | Yes |
|aws_node_termination_handler|False | No |cluster | False | Yes |
|aws_efs_csi_driver|False | No ||
|aws_ebs_csi_driver|False | No ||
|karpenter|False | No |
|calico_tigera|False | No |
|istio_ingress|False | No |
|kiali_server|False | No |
|fluent_bit|False | No |
|new_relic|False | No |
|velero|False | No |

<br/>

**To Provide path of kubectl mainfests -**

| Name | Description| Default | Required |
|------|------------|---------|----------|
|istio_manifests| .yaml manifests to create `ingress` and `gateway` with specified `host` | An empty string is set as path for `ingress` and `gateway` | Yes |
|kiali_manifests| Includes VirtualService manifest file path | An empty string is set as path for `kiali-virtualService.yaml` | Yes |
|externalsecrets_manifests| To create ExternalSecret, SecretStore and SecretManger of your name. | An empty string is set as path for `ExternalSecret` and `SecretStore` yaml files. SecretManager Name: `addon-external_secrets` | Yes |

</br>

**To Provide path of override-values.yaml-**
| Name |Default | Required |
|------|--------|----------|
|metrics_server_helm_config | [click here](https://github.com/clouddrove/terraform-aws-eks-addons/blob/master/override_values.tf#L5-L37) | No |
|cluster_autoscaler_helm_config | [click here](https://github.com/clouddrove/terraform-aws-eks-addons/blob/master/override_values.tf#L46-L69) | No |
|aws_load_balancer_controller_helm_config | [click here](https://github.com/clouddrove/terraform-aws-eks-addons/blob/master/override_values.tf#L78-L100) | No |
|aws_node_termination_handler_helm_config | [click here](https://github.com/clouddrove/terraform-aws-eks-addons/blob/master/override_values.tf#L109-L132) | No |
|aws_efs_csi_driver_helm_config | [click here](https://github.com/clouddrove/terraform-aws-eks-addons/blob/master/override_values.tf#L141-L163) | No |
|aws_ebs_csi_driver_helm_config | [click here](https://github.com/clouddrove/terraform-aws-eks-addons/blob/master/override_values.tf#L172-L213) | No |
|karpenter_helm_config | [click here](https://github.com/clouddrove/terraform-aws-eks-addons/blob/master/override_values.tf#L222-L246) | No |
|calico_tigera_helm_config | [click here](https://github.com/clouddrove/terraform-aws-eks-addons/blob/master/override_values.tf#L294-L304) | No |
|istio_ingress_helm_config | [click here](https://github.com/clouddrove/terraform-aws-eks-addons/blob/master/override_values.tf#L252-L257) | No |
|kiali_server_helm_config | [click here](https://github.com/clouddrove/terraform-aws-eks-addons/blob/master/override_values.tf#L265-L285) | No |
|external_secrets_helm_config | [click here](https://github.com/clouddrove/terraform-aws-eks-addons/blob/master/override_values.tf#L312-L328) | No |
|ingress_nginx_helm_config | [click here](https://github.com/clouddrove/terraform-aws-eks-addons/blob/master/override_values.tf#L337-L380) | No |
|kubeclarity_helm_config | [click here](https://github.com/clouddrove/terraform-aws-eks-addons/blob/master/override_values.tf#L389-L410) | No |
|fluent_bit_helm_config | [click here](https://github.com/clouddrove/terraform-aws-eks-addons/blob/master/override_values.tf#L420-L509) | No |
|new_relic_helm_config | [click here](https://github.com/clouddrove/terraform-aws-eks-addons/blob/master/override_values.tf#L519-L536) | No |
|velero_helm_config | [click here](https://github.com/clouddrove/terraform-aws-eks-addons/blob/master/override_values.tf#L545-L580) | No |

</br>

**To Override [attributes](https://github.com/clouddrove/terraform-aws-eks-addons/blob/master/addons/helm/main.tf#L4-L33) of helm_release resource -**
| Name | Required |
|------|----------|
| metrics_server_extra_configs | No |
| cluster_autoscaler_extra_configs | No |
| karpenter_extra_configs | No |
| aws_load_balancer_controller_extra_configs | No |
| aws_node_termination_handler_extra_configs | No |
| aws_efs_csi_driver_extra_configs | No |
| aws_ebs_csi_driver_extra_configs | No |
| calico_tigera_extra_configs | No |
| istio_ingress_extra_configs | No |
| kiali_server_extra_configs | No |
| external_secrets_extra_configs | No |
| ingress_nginx_extra_configs | No |
| kubeclarity_extra_configs | No |
| fluent_bit_extra_configs | No |
| new_relic_extra_configs | No |
| velero_extra_configs | No |


## Outputs
| Name | Description |
|------|-------------|
| metrics_server_namespace | namespace where metrics-server is deployed | 
| metrics_server_chart_version | Chart version of metrics-server addon's helmchart | 
| metrics_server_repository | Repository URL of metrics-server helmchart | 
| aws_load_balancer_controller_service_account | ServiceAccount name created by IRSA module for aws-load-balancer-controller| 
| aws_load_balancer_controller_iam_policy | IAM Policy used to create IRSA | 
| aws_load_balancer_controller_namespace | namespace where aws-load-balancer-controller is deployed | 
| aws_load_balancer_controller_chart_version | Chart version of aws-load-balancer-controller addon's helmchart | 
| aws_load_balancer_controller_repository | Repository URL of aws-load-balancer-controller helmchart |
| cluster_autoscaler_service_account | ServiceAccount name created by IRSA module for cluster-autoscaler| 
| cluster_autoscaler_iam_policy | IAM Policy used to create IRSA | 
| cluster_autoscaler_namespace | namespace where cluster-autoscaler is deployed | 
| cluster_autoscaler_chart_version | Chart version of cluster-autoscaler addon's helmchart | 
| cluster_autoscaler_repository | Repository URL of cluster-autoscaler helmchart | 
| aws_efs_csi_driver_service_account | ServiceAccount name created by IRSA module for aws-efs-csi-driver | 
| aws_efs_csi_driver_iam_policy | IAM Policy used to create IRSA | 
| aws_efs_csi_driver_namespace | namespace where aws-efs-csi-driver is deployed | 
| aws_efs_csi_driver_chart_version | Chart version of aws-efs-csi-driver addon's helmchart | 
| aws_efs_csi_driver_repository | Repository URL of aws-efs-csi-driver helmchart | 
| aws_ebs_csi_driver_service_account | ServiceAccount name created by IRSA module for aws-ebs-csi-driver | 
| aws_ebs_csi_driver_iam_policy | IAM Policy used to create IRSA | 
| aws_ebs_csi_driver_namespace | namespace where aws-ebs-csi-driver is deployed | 
| aws_ebs_csi_driver_chart_version | Chart version of aws-ebs-csi-driver addon's helmchart | 
| aws_ebs_csi_driver_repository | Repository URL of aws-ebs-csi-driver helmchart | 
| karpenter_service_account | ServiceAccount name created by IRSA module for karpenter | 
| karpenter_iam_policy | IAM Policy used to create IRSA | 
| karpenter_namespace | namespace where karpenter is deployed | 
| karpenter_chart_version | Chart version of karpenter addon's helmchart | 
| karpenter_repository | Repository URL of karpenter helmchart | 
| istio_ingress_namespace | namespace where istio-ingress is deployed | 
| istio_ingress_chart_version | Chart version of istio-ingress addon's helmchart | 
| istio_ingress_repository | Repository URL of istio-ingress helmchart | 
| kiali_server_namespace | namespace where kiali-dashboard is deployed | 
| kiali_server_chart_version | Chart version of kiali-dashboard addon's helmchart | 
| kiali_server_repository | Repository URL of kiali-dashboard helmchart | 
| calico_tigera_namespace | namespace where calico is deployed | 
| calico_tigera_chart_version | Chart version of calico addon's helmchart | 
| calico_tigera_repository | Repository URL of calico helmchart | 
| external_secrets_secret_manager_name | Name of AWS Secret Manager Created by external-secret addon |
| external_secrets_service_account |ServiceAccount name created by IRSA module for external-secret | 
| external_secrets_namespace | namespace where external-secret is deployed | 
| external_secrets_chart_version | Chart version of external-secret addon's helmchart | 
| external_secrets_repository | Repository URL of external-secret helmchart | 
| ingress_nginx_namespace | namespace where ingress-nginx is deployed | 
| ingress_nginx_chart_version | Chart version of ingress-nginx addon's helmchart | 
| ingress_nginx_repository | Repository URL of ingress-nginx helmchart | 
| kubeclarity_namespace | namespace where kubeclarity is deployed | 
| kubeclarity_chart_version | Chart version of kubeclarity addon's helmchart | 
| kubeclarity_repository | Repository URL of kubeclarity helmchart | 
| fluent_bit_service_account | ServiceAccount name created by IRSA module for fluent-bit| 
| fluent_bit_iam_policy | IAM Policy used to create IRSA | 
| fluent_bit_namespace | namespace where fluent-bit is deployed | 
| fluent_bit_chart_version | Chart version of fluent-bit addon's helmchart | 
| fluent_bit_repository | Repository URL of fluent-bit helmchart |
| new_relic_namespace | namespace where new-relic is deployed | 
| new_relic_chart_version | Chart version of new-relic addon's helmchart | 
| new_relic_repository | Repository URL of new-relic helmchart |
| velero_service_account | ServiceAccount name created by IRSA module for velero| 
| velero_iam_policy | IAM Policy used to create IRSA | 
| velero_namespace | namespace where velero is deployed | 
| velero_chart_version | Chart version of velero addon's helmchart | 
| velero_repository | Repository URL of velero helmchart |

## How to Use

- A complete documentation to use `Calico` with AWS EKS is present [here](https://docs.aws.amazon.com/eks/latest/userguide/calico.html)

- Use below terraform module in your infrastructure's terraform script.

```bash
module "addons" {
  source  = "clouddrove/eks-addons/aws"
  version = "0.0.8"

  depends_on       = [module.eks]
  eks_cluster_name = module.eks.cluster_name

  # -- Enable Addons
  metrics_server               = true
  cluster_autoscaler           = true
  aws_load_balancer_controller = true
  aws_node_termination_handler = true
  aws_efs_csi_driver           = true
  aws_ebs_csi_driver           = true
  karpenter                    = false
  calico_tigera                = false
  kubeclarity                  = true
  ingress_nginx                = true
  velero                       = true
  new_relic                    = true

  # -- Addons with mandatory variable
  istio_ingress             = true
  istio_manifests           = var.istio_manifests
  kiali_server              = true
  kiali_manifests           = var.kiali_manifests
  external_secrets          = true
  externalsecrets_manifests = var.externalsecrets_manifests
}

```

## Known Issues

- ### Istio Ingress
  - Our `istio-ingress` addon creates an Application Load Balancer on AWS by using `aws-load-balancer-controller`. 
  - aws-load-balancer-controller adds a `finalizer` field in `ingress` resource to prevent its manual deletion.
  - Another case is that, this ingress will be **non-deletable** if aws-load-balancer-controller gets deleted before deletion of ingress
  - Terraform does not controlls order of destructure which is sometimes causing `aws-load-balancer-controller` helmchart | uninstallation before istio-ingress deletion. 
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
  1. Run below patch command to remove `finalizer` field from both the serviceAccount. 
  ```bash
  kubectl patch serviceAccount calico-cni-plugin calico-node -n calico-system -p '{"metadata":{"finalizers":[]}}' --type=merge
  ```
  2. If both serviceAccount aren't deleted yet then run below command to delete them 
  ```bash
  kubectl delete serviceAccount calico-cni-plugin calico-node -n calico-system
  ```
  3. Delete `calico-system` namespace also by running `kubectl delete namespace calico-system` command. Wait for some time until successful deletion of the namespace. 



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
