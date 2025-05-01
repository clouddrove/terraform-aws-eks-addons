## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| actions\_runner\_controller | Enable actions\_runner\_controller add-on | `bool` | `false` | no |
| actions\_runner\_controller\_extra\_configs | Override attributes of helm\_release terraform resource | `any` | `{}` | no |
| actions\_runner\_controller\_helm\_config | Path to override-values.yaml for actions\_runner\_controller Chart | `any` | `null` | no |
| aws\_ebs\_csi\_driver | Enable AWS EBS CSI Driver add-on | `bool` | `false` | no |
| aws\_ebs\_csi\_driver\_extra\_configs | Override attributes of helm\_release terraform resource | `any` | `{}` | no |
| aws\_ebs\_csi\_driver\_helm\_config | Path to override-values.yaml for EBS CSI Driver Helm Chart | `any` | `null` | no |
| aws\_ebs\_csi\_driver\_iampolicy\_json\_content | Custom IAM Policy for EBS CSI Driver IRSA | `string` | `null` | no |
| aws\_efs\_csi\_driver | Enable AWS EFS CSI Driver add-on | `bool` | `false` | no |
| aws\_efs\_csi\_driver\_extra\_configs | Override attributes of helm\_release terraform resource | `any` | `{}` | no |
| aws\_efs\_csi\_driver\_helm\_config | Path to override-values.yaml for AWS EFS CSI Driver Helm Chart | `any` | `null` | no |
| aws\_efs\_csi\_driver\_iampolicy\_json\_content | Custom IAM Policy for EFS CSI Driver IRSA | `string` | `null` | no |
| aws\_load\_balancer\_controller | Enable AWS Load Balancer Controller add-on | `bool` | `false` | no |
| aws\_load\_balancer\_controller\_extra\_configs | Override attributes of helm\_release terraform resource | `any` | `{}` | no |
| aws\_load\_balancer\_controller\_helm\_config | Path to override-values.yaml for AWS Load Balancer Controller Helm Chart | `any` | `null` | no |
| aws\_load\_balancer\_controller\_iampolicy\_json\_content | Custom IAM Policy for Load Balancer Controller IRSA | `string` | `null` | no |
| aws\_node\_termination\_handler | Enable AWS Node Termination Handler add-on | `bool` | `false` | no |
| aws\_node\_termination\_handler\_extra\_configs | Override attributes of helm\_release terraform resource | `any` | `{}` | no |
| aws\_node\_termination\_handler\_helm\_config | Path to override-values.yaml for AWS Node Termination Handler Helm Chart | `any` | `null` | no |
| aws\_xray | Enable AWS XRAY add-on | `bool` | `false` | no |
| aws\_xray\_extra\_configs | Override attributes of helm\_release terraform resource | `any` | `{}` | no |
| aws\_xray\_helm\_config | Path to override-values.yaml for AWS X-Ray Helm Chart | `any` | `null` | no |
| aws\_xray\_iampolicy\_json\_content | Custom IAM Policy for AWS X-Ray IRSA | `string` | `null` | no |
| calico\_tigera | Enable Tigera's Calico add-on | `bool` | `false` | no |
| calico\_tigera\_extra\_configs | Override attributes of helm\_release terraform resource | `any` | `{}` | no |
| calico\_tigera\_helm\_config | Path to override-values.yaml for Calico Helm Chart | `any` | `null` | no |
| certification\_manager | Enable certification\_manager add-on | `bool` | `false` | no |
| certification\_manager\_extra\_configs | Override attributes of helm\_release terraform resource | `any` | `{}` | no |
| certification\_manager\_helm\_config | Path to override-values.yaml for Certification Manager Chart | `any` | `null` | no |
| cluster\_autoscaler | Enable Cluster Autoscaler add-on | `bool` | `false` | no |
| cluster\_autoscaler\_extra\_configs | Override attributes of helm\_release terraform resource | `any` | `{}` | no |
| cluster\_autoscaler\_helm\_config | Path to override-values.yaml for Cluster Autoscaler Helm Chart | `any` | `null` | no |
| cluster\_autoscaler\_iampolicy\_json\_content | Custom IAM Policy for ClusterAutoscaler IRSA | `string` | `null` | no |
| data\_plane\_wait\_arn | This waits for the data plane to be ready | `string` | `""` | no |
| eks\_cluster\_name | Name of eks cluster | `string` | `""` | no |
| external\_dns | Enable External DNS add-on | `bool` | `false` | no |
| external\_dns\_extra\_configs | Override attributes of helm\_release terraform resource | `any` | `{}` | no |
| external\_dns\_helm\_config | Path to override-values.yaml for External DNS Helm Chart | `any` | `null` | no |
| external\_dns\_iampolicy\_json\_content | Custom IAM Policy for External DNS | `string` | `null` | no |
| external\_secrets | Enable External-Secrets add-on | `bool` | `false` | no |
| external\_secrets\_extra\_configs | Override attributes of helm\_release terraform resource | `any` | `{}` | no |
| external\_secrets\_helm\_config | Path to override-values.yaml for External-Secrets Helm Chart | `any` | `null` | no |
| external\_secrets\_iampolicy\_json\_content | Custom IAM Policy for External-Secrets IRSA | `string` | `null` | no |
| filebeat | Enable Filebeat add-on | `bool` | `false` | no |
| filebeat\_extra\_configs | Override attributes of helm\_release terraform resource | `any` | `{}` | no |
| filebeat\_helm\_config | Filebeat Helm Chart config | `any` | `null` | no |
| fluent\_bit | Enable FluentBit add-on | `bool` | `false` | no |
| fluent\_bit\_extra\_configs | Override attributes of helm\_release terraform resource | `any` | `{}` | no |
| fluent\_bit\_helm\_config | Path to override-values.yaml for FluentBit Helm Chart | `any` | `null` | no |
| fluent\_bit\_iampolicy\_json\_content | Custom IAM Policy for FluentBit IRSA | `string` | `null` | no |
| grafana | Enable Grafana add-on | `bool` | `false` | no |
| grafana\_extra\_configs | Override attributes of helm\_release terraform resource | `any` | `{}` | no |
| grafana\_helm\_config | Grafana Helm Chart config | `any` | `null` | no |
| grafana\_manifests | Path of virtual-service yaml manifests | <pre>object({<br>    grafana_virtualservice_file_path = string<br>  })</pre> | <pre>{<br>  "grafana_virtualservice_file_path": ""<br>}</pre> | no |
| ingress\_nginx | Enable ingress nginx add-on | `bool` | `false` | no |
| ingress\_nginx\_extra\_configs | Override attributes of helm\_release terraform resource | `any` | `null` | no |
| ingress\_nginx\_helm\_config | Path to override-values.yaml for Ingress Nginx Helm Chart | `any` | `null` | no |
| irsa\_iam\_permissions\_boundary | IRSA Input configuration for the addon\_context | `any` | `{}` | no |
| irsa\_iam\_role\_path | IRSA Input configuration for the addon\_context | `any` | `{}` | no |
| istio\_ingress | Enable Istio Ingress add-on | `bool` | `false` | no |
| istio\_ingress\_extra\_configs | Override attributes of helm\_release terraform resource | `any` | `{}` | no |
| istio\_ingress\_helm\_config | Path to override-values.yaml for Istio Ingress  Helm Chart | `any` | `null` | no |
| istio\_manifests | Path of Ingress and Gateway yaml manifests | <pre>object({<br>    istio_ingress_manifest_file_path = list(any)<br>    istio_gateway_manifest_file_path = list(any)<br>  })</pre> | <pre>{<br>  "istio_gateway_manifest_file_path": [<br>    ""<br>  ],<br>  "istio_ingress_manifest_file_path": [<br>    ""<br>  ]<br>}</pre> | no |
| jaeger | Enable jaeger add-on | `bool` | `false` | no |
| jaeger\_extra\_configs | Override attributes of helm\_release terraform resource | `any` | `{}` | no |
| jaeger\_helm\_config | Path to override-values.yaml for Jaeger Chart | `any` | `null` | no |
| karpenter | Enable KARPENTER add-on | `bool` | `false` | no |
| karpenter\_extra\_configs | Override attributes of helm\_release terraform resource | `any` | `{}` | no |
| karpenter\_helm\_config | Path to override-values.yaml for Karpenter Helm Chart | `any` | `null` | no |
| karpenter\_iampolicy\_json\_content | Custom IAM Policy for Karpenter IRSA | `string` | `null` | no |
| keda | Enable Keda add-on | `bool` | `false` | no |
| keda\_extra\_configs | Override attributes of helm\_release terraform resource | `any` | `{}` | no |
| keda\_helm\_config | Path to override-values.yaml for Keda Helm Chart | `any` | `null` | no |
| kiali\_manifests | Path of virtual-service yaml manifests | <pre>object({<br>    kiali_virtualservice_file_path = string<br>  })</pre> | <pre>{<br>  "kiali_virtualservice_file_path": ""<br>}</pre> | no |
| kiali\_server | Enable kiali server add-on | `bool` | `false` | no |
| kiali\_server\_extra\_configs | Override attributes of helm\_release terraform resource | `any` | `{}` | no |
| kiali\_server\_helm\_config | Path to override-values.yaml for Kiali Server Helm Chart | `any` | `null` | no |
| kube\_state\_metrics | Enable Kube-State-Metrics add-on | `bool` | `false` | no |
| kube\_state\_metrics\_extra\_configs | Override attributes of helm\_release terraform resource | `any` | `{}` | no |
| kube\_state\_metrics\_helm\_config | Kube-State-Metrics Helm Chart config | `any` | `null` | no |
| kubeclarity | Enable Kubeclarity add-on | `bool` | `false` | no |
| kubeclarity\_extra\_configs | Override attributes of helm\_release terraform resource | `any` | `{}` | no |
| kubeclarity\_helm\_config | Path to override-values.yaml for Kubeclarity Helm Chart | `any` | `null` | no |
| loki | Enable loki add-on | `bool` | `false` | no |
| loki\_extra\_configs | Override attributes of helm\_release terraform resource | `any` | `{}` | no |
| loki\_helm\_config | Path to override-values.yaml for Loki Chart | `any` | `null` | no |
| manage\_via\_gitops | Set this to `true` if managing addons via GitOps. Seting `true` will not create helm-release for addon. | `bool` | `false` | no |
| metrics\_server | Enable metrics server add-on | `bool` | `false` | no |
| metrics\_server\_extra\_configs | Override attributes of helm\_release terraform resource | `any` | `{}` | no |
| metrics\_server\_helm\_config | Path to override-values.yaml for Metrics Server Helm Chart | `any` | `null` | no |
| new\_relic | Enable New-Relic-Agent add-on | `bool` | `false` | no |
| new\_relic\_extra\_configs | Override attributes of helm\_release terraform resource | `any` | `{}` | no |
| new\_relic\_helm\_config | New-Relic Helm Chart config | `any` | `null` | no |
| prometheus | Enable prometheus add-on | `bool` | `false` | no |
| prometheus\_cloudwatch\_exporter | Enable Prometheus Cloudwatch Exporter add-on | `bool` | `false` | no |
| prometheus\_cloudwatch\_exporter\_extra\_configs | Override attributes of helm\_release terraform resource | `any` | `{}` | no |
| prometheus\_cloudwatch\_exporter\_helm\_config | Path to override-values.yaml for Promtheus Cloudwatch Exporter Chart | `any` | `null` | no |
| prometheus\_cloudwatch\_exporter\_role\_iampolicy\_json\_content | Custom IAM Policy for Prometheus Cloudwatch Exporter's Role | `string` | `null` | no |
| prometheus\_cloudwatch\_exporter\_secret\_manifest | Path of prometheus cloudwatch exporter manifest | `string` | `null` | no |
| prometheus\_extra\_configs | Override attributes of helm\_release terraform resource | `any` | `{}` | no |
| prometheus\_helm\_config | Prometheus Helm Chart config | `any` | `null` | no |
| redis | Enable Redis add-on | `bool` | `false` | no |
| redis\_extra\_configs | Override attributes of helm\_release terraform resource | `any` | `{}` | no |
| redis\_helm\_config | Path to override-values.yaml for Redis Helm Chart | `any` | `null` | no |
| reloader | Enable Reloader add-on | `bool` | `false` | no |
| reloader\_extra\_configs | Override attributes of helm\_release terraform resource | `any` | `{}` | no |
| reloader\_helm\_config | Path to override-values.yaml for Reloader Helm Chart | `any` | `null` | no |
| tags | IRSA Input configuration for the addon\_context | `any` | `{}` | no |
| velero | Enable Velero add-on | `bool` | `false` | no |
| velero\_extra\_configs | Override attributes of helm\_release terraform resource | `any` | `{}` | no |
| velero\_helm\_config | Path to override-values.yaml for Velero Helm Chart | `any` | `null` | no |
| velero\_iampolicy\_json\_content | Custom IAM Policy for Velero IRSA | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| actions\_runner\_controller\_chart\_version | Chart version of the actions\_runner\_controller Helm Chart. |
| actions\_runner\_controller\_namespace | The namespace where actions\_runner\_controller is deployed. |
| actions\_runner\_controller\_repository | Helm chart repository of the actions\_runner\_controller. |
| aws\_ebs\_csi\_driver\_chart\_version | chart version used for aws-ebs-csi-driver helmchart |
| aws\_ebs\_csi\_driver\_iam\_policy | IAM Policy name used in aws-ebs-csi-driver irsa |
| aws\_ebs\_csi\_driver\_namespace | Namespace where aws-ebs-csi-driver is installed |
| aws\_ebs\_csi\_driver\_repository | helm repository url of aws-ebs-csi-driver |
| aws\_ebs\_csi\_driver\_service\_account | name of aws-ebs-csi-driver service-account |
| aws\_efs\_csi\_driver\_chart\_version | chart version used for aws-efs-csi-driver helmchart |
| aws\_efs\_csi\_driver\_iam\_policy | IAM Policy name used in aws-efs-csi-driver irsa |
| aws\_efs\_csi\_driver\_namespace | Namespace where aws-efs-csi-driver is installed |
| aws\_efs\_csi\_driver\_repository | helm repository url of aws-efs-csi-driver |
| aws\_efs\_csi\_driver\_service\_account | name of aws-efs-csi-driver service-account |
| aws\_load\_balancer\_controller\_chart\_version | chart version used for aws-load-balancer-controller helmchart |
| aws\_load\_balancer\_controller\_iam\_policy | IAM Policy name used in aws-load-balancer-controller irsa |
| aws\_load\_balancer\_controller\_namespace | Namespace where aws-load-balancer-controller is installed |
| aws\_load\_balancer\_controller\_repository | helm repository url of aws-load-balancer-controller |
| aws\_load\_balancer\_controller\_service\_account | name of aws-load-balancer-controller service-account |
| calico\_tigera\_chart\_version | chart version used for calico-tigera helmchart |
| calico\_tigera\_namespace | Namespace where calico-tigera is installed |
| calico\_tigera\_repository | helm repository url of calico-tigera |
| certification\_manager\_chart\_version | Chart version of the certification-manager Helm Chart. |
| certification\_manager\_namespace | The namespace where certification-manager is deployed. |
| certification\_manager\_repository | Helm chart repository of the certification-manager. |
| cluster\_autoscaler\_chart\_version | chart version used for cluster-autoscaler helmchart |
| cluster\_autoscaler\_iam\_policy | IAM Policy name used in cluster-autoscaler irsa |
| cluster\_autoscaler\_namespace | Namespace where cluster-autoscaler is installed |
| cluster\_autoscaler\_repository | helm repository url of cluster-autoscaler |
| cluster\_autoscaler\_service\_account | name of cluster-autoscaler service-account |
| external\_dns\_chart\_version | Chart version of the external dns Helm Chart. |
| external\_dns\_namespace | The namespace where external dns is deployed. |
| external\_dns\_repository | Helm chart repository of the external dns. |
| external\_secrets\_chart\_version | chart version used for external-secrets helmchart |
| external\_secrets\_iam\_policy | Name of IAM Policy used in external-secrets irsa |
| external\_secrets\_namespace | Namespace where external-secrets is installed |
| external\_secrets\_repository | helm repository url of external-secrets |
| external\_secrets\_service\_account | name of external-secrets service-account |
| filebeat\_chart\_version | chart version used for Filebeat helmchart |
| filebeat\_namespace | Namespace where Filebeat is installed |
| filebeat\_repository | helm repository url of Filebeat |
| fluent\_bit\_chart\_version | chart version used for fluent-bit helmchart |
| fluent\_bit\_iam\_policy | IAM Policy name used in fluent-bit irsa |
| fluent\_bit\_namespace | Namespace where fluent-bit is installed |
| fluent\_bit\_repository | helm repository url of fluent-bit |
| fluent\_bit\_service\_account | name of fluent-bit service-account |
| grafana\_chart\_version | Chart version of the grafana Helm Chart. |
| grafana\_namespace | The namespace where grafana is deployed. |
| grafana\_repository | Helm chart repository of the grafana. |
| ingress\_nginx\_chart\_version | chart version used for ingress-nginx helmchart |
| ingress\_nginx\_namespace | Namespace where ingress-nginx is installed |
| ingress\_nginx\_repository | helm repository url of ingress-nginx |
| istio\_ingress\_chart\_version | chart version used for istio-ingress helmchart |
| istio\_ingress\_namespace | Namespace where istio-ingress is installed |
| istio\_ingress\_repository | helm repository url of istio-ingress |
| jaeger\_chart\_version | Chart version of the jaeger Helm Chart. |
| jaeger\_namespace | The namespace where jaeger is deployed. |
| jaeger\_repository | Helm chart repository of the jaeger. |
| karpenter\_chart\_version | chart version used for karpenter helmchart |
| karpenter\_iam\_policy | IAM Policy name used in karpenter irsa |
| karpenter\_namespace | Namespace where karpenter is installed |
| karpenter\_repository | helm repository url of karpenter |
| karpenter\_service\_account | name of karpenter service-account |
| keda\_chart\_version | Chart version of the Keda Helm Chart. |
| keda\_namespace | The namespace where Keda is deployed. |
| keda\_repository | Helm chart repository of the Keda. |
| kiali\_server\_chart\_version | chart version used for kiali-server helmchart |
| kiali\_server\_namespace | Namespace where kiali-server is installed |
| kiali\_server\_repository | helm repository url of kiali-server |
| kube\_state\_metrics\_chart\_version | Chart version of the Kube-State-Metrics Helm Chart. |
| kube\_state\_metrics\_namespace | The namespace where Kube-State-Metrics is deployed. |
| kube\_state\_metrics\_repository | Helm chart repository of the Kube-State-Metrics. |
| kubeclarity\_chart\_version | chart version used for kubeclarity helmchart |
| kubeclarity\_namespace | Namespace where kubeclarity is installed |
| kubeclarity\_repository | helm repository url of kubeclarity |
| loki\_chart\_version | Chart version of the loki Helm Chart. |
| loki\_namespace | The namespace where loki is deployed. |
| loki\_repository | Helm chart repository of the loki. |
| metrics\_server\_chart\_version | chart version used for metrics-server helmchart |
| metrics\_server\_namespace | Namespace where metrics-server is installed |
| metrics\_server\_repository | helm repository url of metrics-server |
| new\_relic\_chart\_version | chart version used for new-relic helmchart |
| new\_relic\_namespace | Namespace where new-relic is installed |
| new\_relic\_repository | helm repository url of new-relic |
| prometheus\_chart\_version | Chart version of the prometheus Helm Chart. |
| prometheus\_cloudwatch\_exporter\_chart\_version | Chart version of the Prometheus Cloudwatch Exporter Helm Chart. |
| prometheus\_cloudwatch\_exporter\_namespace | The namespace where Prometheus Cloudwatch Exporter is deployed. |
| prometheus\_cloudwatch\_exporter\_repository | Helm chart repository of the Prometheus Cloudwatch Exporter. |
| prometheus\_namespace | The namespace where prometheus is deployed. |
| prometheus\_repository | Helm chart repository of the prometheus. |
| redis\_chart\_version | Chart version of the Redis Helm Chart. |
| redis\_namespace | The namespace where Redis is deployed. |
| redis\_repository | Helm chart repository of the Redis. |
| reloader\_chart\_version | Chart version of the reloader Helm Chart. |
| reloader\_namespace | The namespace where reloader is deployed. |
| reloader\_repository | Helm chart repository of the reloader. |
| velero\_chart\_version | chart version used for velero helmchart |
| velero\_iam\_policy | IAM Policy name used in velero irsa |
| velero\_namespace | Namespace where velero is installed |
| velero\_repository | helm repository url of velero |
| velero\_service\_account | name of velero service-account |

