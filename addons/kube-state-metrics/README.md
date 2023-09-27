# Kube-State-Metrics Helm Chart

kube-state-metrics (KSM) is a simple service that listens to the Kubernetes API server and generates metrics about the state of the objects. (See examples in the Metrics section below.) It is not focused on the health of the individual Kubernetes components, but rather on the health of the various objects inside, such as deployments, nodes and pods. Look into this [official Doc](https://github.com/kubernetes/kube-state-metrics) of Kube-State-Metrics for more further information.


## Installation
Below terraform script shows how to use External Secrets Terraform Addon, A complete example is also given [here](https://github.com/clouddrove/terraform-helm-eks-addons/blob/master/_examples/complete/main.tf).


```hcl
module "addons" {
  source  = "clouddrove/eks-addons/aws"
  version = "0.0.6"
  
  depends_on       = [module.eks]
  eks_cluster_name = module.eks.cluster_name

  kube_state_metrics              = true
  kube_state_metrics_helm_config  = { values = [file("./config/override-kube-state-matrics.yaml")] }
}
```


<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->