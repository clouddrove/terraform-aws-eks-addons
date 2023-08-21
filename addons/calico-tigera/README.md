# Calico Helm Chart

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

If you’re running a Kubernetes Cluster in an AWS Cloud using Amazon EKS, the default Container Network Interface (CNI) plugin for Kubernetes is  [amazon-vpc-cni-k8s](https://github.com/aws/amazon-vpc-cni-k8s). By using this CNI plugin your Kubernetes pods will have the same IP address inside the pod as they do on the VPC network. The problem with this CNI is the large number of VPC IP addresses required to run and manage huge clusters. This is the reason why other CNI plugins such as Calico is an option.


Calico is a free to use and open source networking and network security plugin that supports a broad range of platforms including Docker EE, OpenShift, Kubernetes, OpenStack, and bare metal services. Calico offers true cloud-native scalability and delivers blazing fast performance. With Calico you have the options to use either Linux eBPF or the Linux kernel’s highly optimized standard networking pipeline to deliver high performance networking.

For multi-tenant Kubernetes environments where isolation of tenants from each other is key, Calico network policy enforcement can be used to implement network segmentation and tenant isolation. You can easily create network ingress and egress rules to ensure proper network controls are applied to services.

## Installation
- Below terraform script shows how to use Calico Terraform Addon, A complete example is also given [here](https://github.com/clouddrove/terraform-helm-eks-addons/blob/master/_examples/complete/main.tf).
- Calico is an CNI addon, so this must be installed before EKS default CNI (aws-node). 
- If you see `aws-node` pods after cluster creation `kubectl get pods -n kube-system` then you can just delete them by running `kubectl delete ds aws-node -n kube-system`

```bash
module "addons" {
  source  = "clouddrove/eks-addons/aws"
  version = "0.0.1"
  
  depends_on       = [module.eks.cluster_id]
  eks_cluster_name = module.eks.cluster_name

  calico_tigera = true
}
```


## Inputs

| Name | Description | Default | Required |
|------|-------------|---------|:--------:|
| eks_cluster_name | Name of Kubernetes Cluster in which you want to install Calico |  | Yes |
| calico_tigera | Set this to **true** to install Calico helmchart. | false | Yes |
| calico_tigera_helm_config | Provide path to override-values.yaml of calico_tigera | { values = ["${file("./config/calico-tigera-values.yaml")}"] } | No |


<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
