# External Secrets Helm Chart

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
External Secrets Operator is a Kubernetes operator that integrates external secret management systems like AWS Secrets Manager, HashiCorp Vault, Google Secrets Manager, Azure Key Vault, IBM Cloud Secrets Manager, Akeyless, CyberArk Conjur and many more. The operator reads information from external APIs and automatically injects the values into a Kubernetes Secret.

## Installation
Below terraform script shows how to use External Secrets Terraform Addon, A complete example is also given [here](https://github.com/clouddrove/terraform-helm-eks-addons/blob/master/_examples/complete/main.tf).

Note : User need to change the properties of SecretStore according to their usage by editing  "/complete/config/external-secret/secret-store.yaml"
and they also need to change properties of ExternalSecrets according to their usage by editing  "/complete/config/external-secret/external-secret.yaml"

```bash
module "addons" {
  source = "../../"
  depends_on       = [null_resource.kubectl]
  eks_cluster_name = module.eks.cluster_name

  external_secrets         = true
  externalsecrets_manifest = var.externalsecrets_manifest
  
}
```


## Inputs

| Name | Description | Default | Required |
|------|-------------|---------|:--------:|
| eks_cluster_name | Name of Kubernetes Cluster in which you want to install External Secrets |  | Yes |
| external_secrets | To install External Secrets helmchart set this to true | false | Yes |
| external_secrets_helm_config | Override [attributes](https://github.com/clouddrove/terraform-helm-eks-addons/blob/master/addons/helm/main.tf#L1-L33) of helm_release terraform resource. | `name`, `chart`, `repository`, `version`, `namespace`,`description` are can not be override | No |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
