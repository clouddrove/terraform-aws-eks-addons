# Prometheus Cloudwatch Exporter Helm Chart

The CloudWatch Exporter for Prometheus is a tool that allows you to export Amazon CloudWatch metrics in the Prometheus format. Amazon CloudWatch is a monitoring and observability service provided by AWS that provides metrics, logs, and traces from AWS resources and applications.

## Installation
Below terraform script describes how to use Prometheus Cloudwatch Exporter Terraform Addon, A complete example is also given [here](https://github.com/clouddrove/terraform-helm-eks-addons/blob/master/_examples/complete/main.tf).
```hcl
module "addons" {
  source  = "clouddrove/eks-addons/aws"
  
  depends_on       = [module.eks.cluster_id]
  eks_cluster_name = module.eks.cluster_name

  prometheus_cloudwatch_exporter = true
}
```

## Configuration
This documentation can help you to configure CloudWatch exporter to get the metrics from AWS.
Configuration examples for different namespaces can be found in [this](https://github.com/prometheus/cloudwatch_exporter/blob/master/examples) examples. 
A configuration builder can be found [here](https://github.com/djloude/cloudwatch_exporter_metrics_config_builder).
Configure the exporter for namespaces accordingly and use it in the `./config/override-prometheus-cloudwatch-exporter-controller.yaml` override file like this.

```yaml
## Node affinity for particular node in which labels key is "Infra-Services" and value is "true"
affinity:
  nodeAffinity:
    requiredDuringSchedulingIgnoredDuringExecution:
      nodeSelectorTerms:
      - matchExpressions:
        - key: "eks.amazonaws.com/nodegroup"
          operator: In
          values:
          - "critical"
## Using limits and requests
resources:
  limits:
    cpu: 300m
    memory: 250Mi
  requests:
    cpu: 50m
    memory: 150Mi
# This config is for AWS Load balancer
config: |-
  # This is the default configuration for prometheus-cloudwatch-exporter
  region: us-east-1
  metrics:
  - aws_dimensions:
    - InstanceId
    aws_metric_name: CPUUtilization
    aws_namespace: AWS/EC2
    aws_statistics:
    - Average
    aws_tag_select:
      resource_type_selection: ec2:instance
      resource_id_dimension: InstanceId
  - aws_dimensions:
    - InstanceId
    aws_metric_name: NetworkIn
    aws_namespace: AWS/EC2
    aws_statistics:
    - Average
  - aws_dimensions:
    - InstanceId
    aws_metric_name: NetworkOut
    aws_namespace: AWS/EC2
    aws_statistics:
    - Average
  - aws_dimensions:
    - InstanceId
    aws_metric_name: NetworkPacketsIn
    aws_namespace: AWS/EC2
    aws_statistics:
    - Average
  - aws_dimensions:
    - InstanceId
    aws_metric_name: NetworkPacketsOut
    aws_namespace: AWS/EC2
    aws_statistics:
    - Average
  - aws_dimensions:
    - InstanceId
    aws_metric_name: DiskWriteBytes
    aws_namespace: AWS/EC2
    aws_statistics:
    - Average
  - aws_dimensions:
    - InstanceId
    aws_metric_name: DiskReadBytes
    aws_namespace: AWS/EC2
    aws_statistics:
    - Average
  - aws_dimensions:
    - InstanceId
    aws_metric_name: CPUCreditBalance
    aws_namespace: AWS/EC2
    aws_statistics:
    - Average
  - aws_dimensions:
    - InstanceId
    aws_metric_name: CPUCreditUsage
    aws_namespace: AWS/EC2
    aws_statistics:
    - Average
  - aws_dimensions:
    - InstanceId
    aws_metric_name: StatusCheckFailed
    aws_namespace: AWS/EC2
    aws_statistics:
    - Sum
  - aws_dimensions:
    - InstanceId
    aws_metric_name: StatusCheckFailed_Instance
    aws_namespace: AWS/EC2
    aws_statistics:
    - Sum
  - aws_dimensions:
    - InstanceId
    aws_metric_name: StatusCheckFailed_System
    aws_namespace: AWS/EC2
    aws_statistics:
    - Sum
```

## Authentication
- There are two methods to Authenticate with AWS

### Using Secrets
- Update Access key and Secret Access keys from the config files provided in the examples.

### Service Account (Default)
- Don't pass secret to use Service Based authentication.
- Minimal Required Permissions are allowed to the service account for Prometheus Cloudwatch Exporter.

## Additional Configuration and Use
- Prometheus Cloudwatch Exporter is just a Exporter, that need to be used in prometheus as a exporter to scrape details from Exporter

### Prometheus Scrape Config
- Checkout [this](https://github.com/clouddrove/terraform-aws-eks-addons/blob/master/_examples/complete/config/override-prometheus.yaml) Prometheus Configuration to add scrape config for Prometheus Cloudwatch Exporter.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 5.29 |
| <a name="requirement_helm"></a> [helm](#requirement\_helm) | 2.9.0 |
| <a name="requirement_kubectl"></a> [kubectl](#requirement\_kubectl) | >= 1.13.0 |
| <a name="requirement_kubernetes"></a> [kubernetes](#requirement\_kubernetes) | >= 2.23 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 5.29 |
| <a name="provider_kubectl"></a> [kubectl](#provider\_kubectl) | >= 1.13.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_prometheus_cloudwatch_exporter_role"></a> [prometheus\_cloudwatch\_exporter\_role](#module\_prometheus\_cloudwatch\_exporter\_role) | ../helm | n/a |
| <a name="module_prometheus_cloudwatch_exporter_secret"></a> [prometheus\_cloudwatch\_exporter\_secret](#module\_prometheus\_cloudwatch\_exporter\_secret) | ../helm | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_iam_policy.policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [kubectl_manifest.secret_manifest](https://registry.terraform.io/providers/gavinbunney/kubectl/latest/docs/resources/manifest) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_addon_context"></a> [addon\_context](#input\_addon\_context) | Input configuration for the addon | <pre>object({<br/>    aws_caller_identity_account_id = string<br/>    aws_caller_identity_arn        = string<br/>    aws_eks_cluster_endpoint       = string<br/>    aws_partition_id               = string<br/>    aws_region_name                = string<br/>    eks_cluster_id                 = string<br/>    eks_oidc_issuer_url            = string<br/>    eks_oidc_provider_arn          = string<br/>    tags                           = map(string)<br/>  })</pre> | n/a | yes |
| <a name="input_eks_cluster_name"></a> [eks\_cluster\_name](#input\_eks\_cluster\_name) | n/a | `string` | `""` | no |
| <a name="input_helm_config"></a> [helm\_config](#input\_helm\_config) | Helm provider config for Prometheus Cloudwatch Exporter | `any` | `{}` | no |
| <a name="input_iampolicy_json_content"></a> [iampolicy\_json\_content](#input\_iampolicy\_json\_content) | Custom IAM Policy for Prometheus Cloudwatch Exporter's Role | `string` | `null` | no |
| <a name="input_manage_via_gitops"></a> [manage\_via\_gitops](#input\_manage\_via\_gitops) | Determines if the add-on should be managed via GitOps | `bool` | `false` | no |
| <a name="input_prometheus_cloudwatch_exporter_extra_configs"></a> [prometheus\_cloudwatch\_exporter\_extra\_configs](#input\_prometheus\_cloudwatch\_exporter\_extra\_configs) | Override attributes of helm\_release terraform resource | `any` | `{}` | no |
| <a name="input_secret_manifest"></a> [secret\_manifest](#input\_secret\_manifest) | Path of Ingress and Gateway yaml manifests | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_chart_version"></a> [chart\_version](#output\_chart\_version) | n/a |
| <a name="output_namespace"></a> [namespace](#output\_namespace) | n/a |
| <a name="output_repository"></a> [repository](#output\_repository) | n/a |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
