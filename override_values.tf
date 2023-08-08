#-----------METRIC SERVER--------------------
resource "local_file" "metrics_server_helm_config" {
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
