# Prometheus Cloudwatch Exporter Helm Chart

The CloudWatch Exporter for Prometheus is a tool that allows you to export Amazon CloudWatch metrics in the Prometheus format. Amazon CloudWatch is a monitoring and observability service provided by AWS that provides metrics, logs, and traces from AWS resources and applications 

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
  region: eu-west-1
  period_seconds: 240
  metrics:
  - aws_namespace: AWS/ELB
    aws_metric_name: HealthyHostCount
    aws_dimensions: [AvailabilityZone, LoadBalancerName]
    aws_statistics: [Average]

  - aws_namespace: AWS/ELB
    aws_metric_name: UnHealthyHostCount
    aws_dimensions: [AvailabilityZone, LoadBalancerName]
    aws_statistics: [Average]

  - aws_namespace: AWS/ELB
    aws_metric_name: RequestCount
    aws_dimensions: [AvailabilityZone, LoadBalancerName]
    aws_statistics: [Sum]

  - aws_namespace: AWS/ELB
    aws_metric_name: Latency
    aws_dimensions: [AvailabilityZone, LoadBalancerName]
    aws_statistics: [Average]

  - aws_namespace: AWS/ELB
    aws_metric_name: SurgeQueueLength
    aws_dimensions: [AvailabilityZone, LoadBalancerName]
    aws_statistics: [Maximum, Sum]

```

## Authentication
- There are two methods to Authenticate with AWS

### Using Secrets
- Update Access key and Secret Access keys from the config files provided in the examples.

### Using Role (Default)
- Don't pass secret to use Role based authentication.
- A Role and Policy will be created for authentication with AWS.
- Pass RoleName if you have existing role for the authentication:
```hcl
prometheus_cloudwatch_exporter_extra_configs = {
  role_name = "prometheus_cloudwatch_exporter_role"
}
```
- To override the default policy create `json` format file and pass it like this:
```hcl
prometheus_cloudwatch_exporter_iampolicy_json_content   = file("./custom-iam-policies/prometheus-cloudwatch-exporter.json")
```

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
