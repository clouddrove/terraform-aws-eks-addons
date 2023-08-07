# External Secrets Helm Chart

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
External Secrets Operator is a Kubernetes operator that integrates external secret management systems like AWS Secrets Manager, HashiCorp Vault, Google Secrets Manager, Azure Key Vault, IBM Cloud Secrets Manager, Akeyless, CyberArk Conjur and many more. The operator reads information from external APIs and automatically injects the values into a Kubernetes Secret.

## Installation
Below terraform script shows how to use External Secrets Terraform Addon, A complete example is also given [here](https://github.com/clouddrove/terraform-helm-eks-addons/blob/master/_examples/complete/main.tf).

- User needs to change the properties (`name`,`namespace`,`region`) of SecretStore according to their usage by editing [secret-store.yaml](https://github.com/clouddrove/terraform-aws-eks-addons/blob/master/_examples/complete/config/external-secret/secret-store.yaml)
and they also need to change properties (`name`,`namespace`,`secretKey`) of ExternalSecrets according to their usage by editing  [external-secret.yaml](https://github.com/clouddrove/terraform-aws-eks-addons/blob/master/_examples/complete/config/external-secret/external-secret.yaml)

- If users wants to add more secrets then they can use following template in `external-secret.yaml` under data:

```bash
data:
- secretKey: do_not_delete_this_key        # -- AWS Secret-Manager secret key
  remoteRef:
    key: addon-external_secrets            # -- Same as 'externalsecrets_manifest["secret_manager_name"]
    property: do_not_delete_this_key       # -- AWS Secret-Manager secret key
```
user also need to provide `secret_manager_name` inside `externalsecrets_manifest` variable in varriable.tf as below
```bash
variable "externalsecrets_manifest" {
  type = object({
    secret_store_manifest_file_path     = string
    external_secrets_manifest_file_path = string
    secret_manager_name                 = string
  })
  default = {
    secret_store_manifest_file_path     = ""
    external_secrets_manifest_file_path = ""

    secret_manager_name                 = "addon/external_secrets"
  }
}
```

Calling `externalsecrets_manifest` variable in main.tf as below -
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
| eks_cluster_name | Name of Kubernetes Cluster in which you want to install External Secrets | na | Yes |
| external_secrets | To install External Secrets helmchart set this to true | false | Yes |
| external_secrets_helm_config | Provide path to override-values.yaml of external-secrets | { values = ["${file("addons/external-secrets/config/external_secrets.yaml")}"] } | No |
| externalsecrets_manifest | Provide path of the `secret-store.yaml` , `external-secret.yaml` and value `secret manager name` | na | Yes |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->