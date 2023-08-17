#-----------METRIC SERVER--------------------
resource "local_file" "metrics_server_helm_config" {
  count    = var.metrics_server ? 1 : 0
  content  = <<EOT
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

## Particular args to be passed in deployment

extraArgs:
  - --kubelet-preferred-address-types=InternalIP
  - --v=2

apiService:
  create: true

## Using limits and requests

resourc_helm_configes:
  limits:
    cpu: 200m
    memory: 250Mi
  requests:
    cpu: 50m
    memory: 150Mi

podAnnotations:
  co.elastic.logs/enabled: "true"
  EOT
  filename = "${path.module}/override_vales/metrics_server.yaml"
}

#-----------CLUSTER AUTOSCALER---------------
resource "local_file" "cluster_autoscaler_helm_config" {
  count    = var.cluster_autoscaler ? 1 : 0
  content  = <<EOT
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
resourc_helm_configes:
  limits:
    cpu: 300m
    memory: 250Mi
  requests:
    cpu: 50m
    memory: 150Mi

podAnnotations:
  co.elastic.logs/enabled: "true"

  EOT
  filename = "${path.module}/override_vales/cluster_autoscaler.yaml"
}
#-----------AWS LOAD BALANCER CONTROLLER ----
resource "local_file" "aws_load_balancer_controller_helm_config" {
  count    = var.aws_load_balancer_controller ? 1 : 0
  content  = <<EOT
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
resourc_helm_configes:
  limits:
    cpu: 300m
    memory: 250Mi
  requests:
    cpu: 50m
    memory: 150Mi

podAnnotations:
  co.elastic.logs/enabled: "true"

  EOT
  filename = "${path.module}/override_vales/aws_load_balancer_controller.yaml"
}
#-----------AWS NODE TERMINATION HANDLER ----
resource "local_file" "aws_node_termination_handler_helm_config" {
  count    = var.aws_node_termination_handler ? 1 : 0
  content  = <<EOT
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

resourc_helm_configes:
  limits:
    cpu: 200m
    memory: 250Mi
  requests:
    cpu: 50m
    memory: 150Mi

podAnnotations:
  co.elastic.logs/enabled: "true"

  EOT
  filename = "${path.module}/override_vales/aws_node_termination_handler.yaml"
}
#-----------AWS EFS CSI DRIVER --------------
resource "local_file" "aws_efs_csi_driver_helm_config" {
  count    = var.aws_efs_csi_driver ? 1 : 0
  content  = <<EOT
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
resourc_helm_configes:
  limits:
    cpu: 300m
    memory: 250Mi
  requests:
    cpu: 50m
    memory: 150Mi

podAnnotations:
  co.elastic.logs/enabled: "true"

  EOT
  filename = "${path.module}/override_vales/aws_efs_csi_driver.yaml"
}
#-----------AWS EBS CSI DRIVER --------------
resource "local_file" "aws_ebs_csi_driver_helm_config" {
  count    = var.aws_ebs_csi_driver ? 1 : 0
  content  = <<EOT
## Node affinity for particular node in which labels key is "Infra-Services" and value is "true"
controller:
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
  resourc_helm_configes:
    limits:
      cpu: 300m
      memory: 250Mi
    requests:
      cpu: 50m
      memory: 150Mi

node:
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
  resourc_helm_configes:
    limits:
      cpu: 300m
      memory: 250Mi
    requests:
      cpu: 50m
      memory: 150Mi

podAnnotations:
  co.elastic.logs/enabled: "true"

  EOT
  filename = "${path.module}/override_vales/aws_ebs_csi_driver.yaml"
}
#-----------KARPENTER -----------------------
resource "local_file" "karpenter_helm_config" {
  count    = var.karpenter ? 1 : 0
  content  = <<EOT
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
resourc_helm_configes:
  limits:
    cpu: 300m
    memory: 250Mi
  requests:
    cpu: 50m
    memory: 150Mi

podAnnotations:
  co.elastic.logs/enabled: "true"

  EOT
  filename = "${path.module}/override_vales/karpenter.yaml"
}
#-----------ISTIO INGRESS--------------------
resource "local_file" "istio_ingress_helm_config" {
  count    = var.istio_ingress ? 1 : 0
  content  = <<EOT
global:
  defaultNodeSelector:
    "eks.amazonaws.com/nodegroup" : "critical"

service:
  type: NodePort
  EOT
  filename = "${path.module}/override_vales/istio_ingress.yaml"
}
#-----------KAILI DASHBOARD------------------
resource "local_file" "kiali_server_helm_config" {
  count    = var.kiali_server ? 1 : 0
  content  = <<EOT
## Node affinity for particular node in which labels key is "Infra-Services" and value is "true"
deployment:
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

  resourc_helm_configes:
    limits:
      cpu: 200m
      memory: 250Mi
    requests:
      cpu: 50m
      memory: 150Mi

  EOT
  filename = "${path.module}/override_vales/kiali_server.yaml"
}
#-----------CALICO TOGERA -------------------
resource "local_file" "calico_tigera_helm_config" {
  count    = var.calico_tigera ? 1 : 0
  content  = <<EOT
installation:
  kubernetesProvider: "EKS"

## Using limits and requests
resourc_helm_configes:
  limits:
    cpu: 300m
    memory: 250Mi
  requests:
    cpu: 50m
    memory: 150Mi
  EOT
  filename = "${path.module}/override_vales/calico_tigera.yaml"
}
#----------- EXTERNAL SECRETS ---------------
resource "local_file" "external_secrets_helm_config" {
  count    = var.external_secrets ? 1 : 0
  content  = <<EOT
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
resourc_helm_configes:
  limits:
    cpu: 300m
    memory: 250Mi
  requests:
    cpu: 50m
    memory: 150Mi
  EOT
  filename = "${path.module}/override_vales/external_secrets.yaml"
}

#-----------KUBECLARITY -----------------------
resource "local_file" "kubeclarity_helm_config" {
  count    = var.kubeclarity ? 1 : 0
  content  = <<EOT
## Using limits and requests
kubeclarity:
  resources:
    limits:
      memory: "500Mi"
      cpu: "200m"
    requests:
      memory: "200Mi"
      cpu: "100m"

  podAnnotations:
    co.elastic.logs/enabled: "true"


# Be careful when using ingress. As there is no authentication on Kubeclarity yet, your instance may be accessible.
# Make sure the ingress remains internal if you decide to enable it.
  service:
    type: LoadBalancer
    port: 80
    annotations:
      service.beta.kubernetes.io/aws-load-balancer-scheme: "internet-facing"
      service.beta.kubernetes.io/aws-load-balancer-name: "kubeclarity"

  EOT
  filename = "${path.module}/override_vales/kubeclarity.yaml"
}

#-----------PROMETHEUS -----------------------

resource "local_file" "prometheus_helm_config" {
  count    = var.prometheus ? 1 : 0
  content  = <<EOT
server:
  service:
    ## If false, no Service will be created for the Prometheus server
    ##
    enabled: true
    annotations: 
      service.beta.kubernetes.io/aws-load-balancer-scheme: "internet-facing"
      service.beta.kubernetes.io/aws-load-balancer-name: "prometheus"
    labels: {}
    clusterIP: ""

    ## List of IP addresses at which the Prometheus server service is available
    ## Ref: https://kubernetes.io/docs/concepts/services-networking/service/#external-ips
    ##
    externalIPs: []
    loadBalancerIP: ""
    loadBalancerSourceRanges: []
    servicePort: 80
    sessionAffinity: None
    type: LoadBalancer

  persistentVolume:
    accessModes:
      - ReadWriteOnce
    enabled: true
    mountPath: /data
    size: 20Gi
    storageClass: gp2
  EOT
  filename = "${path.module}/override_vales/prometheus.yaml"
}