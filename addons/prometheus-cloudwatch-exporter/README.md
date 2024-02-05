# Prometheus Cloudwatch Exporter Helm Chart

The CloudWatch Exporter for Prometheus is a tool that allows you to export Amazon CloudWatch metrics in the Prometheus format. Amazon CloudWatch is a monitoring and observability service provided by AWS that provides metrics, logs, and traces from AWS resources and applications.

## Installation
Below terraform script describes how to use Prometheus Cloudwatch Exporter Terraform Addon, A complete example is also given [here](https://github.com/clouddrove/terraform-helm-eks-addons/blob/master/_examples/complete/main.tf).
```hcl
module "addons" {
  source  = "clouddrove/eks-addons/aws"
  version = "0.0.9"
  
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
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
