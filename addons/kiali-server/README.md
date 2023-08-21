# Kiali Server Helm Chart

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->



## Installation
Below terraform script shows how to use Kiali-Server Terraform Addon, A complete example is also given [here](https://github.com/clouddrove/terraform-helm-eks-addons/blob/master/_examples/complete/main.tf).
```bash
module "addons" {
  source  = "clouddrove/eks-addons/aws"
  version = "0.0.1"
  
  depends_on       = [module.eks.cluster_id]
  eks_cluster_name = module.eks.cluster_name

  kiali_server    = true
  kiali_manifests = var.kiali_manifests
}
```


## Inputs

| Name | Description | Default | Required |
|------|-------------|---------|:--------:|
| eks_cluster_name | Name of Kubernetes Cluster in which you want to install Kiali Server |  | Yes |
| kiali_server | To install Kiali Dashboard helmchart set this to true | false | Yes |
| kiali_manifests { <br/> kiali_virtualservice_file_path <br/>enable_monitoring <br/>} | • Provide path of virtualservice.yaml manifest, which will contain host where the kiali-dashboard webpage will run. <br/> • set `enable_monitoring` to `false` to not to install prometheus and jaeger| monitoring is enabled and is required by kiali-dashboard | Yes |
| kiali_server_helm_config | Provide path to override-values.yaml of kiali_server | `{ values = ["${file("./config/kiali/override-values.yaml")}"] } | No |

## Additional Configurations
- To make Kiali Dashboard work you need to install `istio-ingress` & `aws-load-balancer-controller` addons.
- Kiali Server will be running behind istio-ingress. While using istio-ingress we have to create VirtualService to expose our application. A sample virtual-service.yaml is given [here](https://github.com/clouddrove/terraform-helm-eks-addons/blob/master/addons/kiali-server/config/kiali_vs.yaml)

- Get Kiali Dashboard login password via command
  ```bash
  kubectl get secret kiali-token -n istio-system -o jsonpath={.data.token} | base64 -d
  ```
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
