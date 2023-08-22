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
  filename = "${path.module}/override_values/metrics_server.yaml"
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
  filename = "${path.module}/override_values/cluster_autoscaler.yaml"
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
  filename = "${path.module}/override_values/aws_load_balancer_controller.yaml"
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
  filename = "${path.module}/override_values/aws_node_termination_handler.yaml"
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
  filename = "${path.module}/override_values/aws_efs_csi_driver.yaml"
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
  filename = "${path.module}/override_values/aws_ebs_csi_driver.yaml"
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
  filename = "${path.module}/override_values/karpenter.yaml"
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
  filename = "${path.module}/override_values/istio_ingress.yaml"
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
  filename = "${path.module}/override_values/kiali_server.yaml"
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
  filename = "${path.module}/override_values/calico_tigera.yaml"
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
  filename = "${path.module}/override_values/external_secrets.yaml"
}

#-------------INGRESS NGINX-------------------
resource "local_file" "ingress_nginx_helm_config" {
  count    = var.ingress_nginx ? 1 : 0
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

resources:
  limits:
    cpu: 150m
    memory: 150Mi
  requests:
    cpu: 100m
    memory: 90Mi

podAnnotations:
  co.elastic.logs/enabled: "true"

## Override values for ingress nginx

controller:
  service:
    annotations:
      kubernetes.io/ingress.class: nginx
      service.beta.kubernetes.io/aws-load-balancer-backend-protocol: tcp
      service.beta.kubernetes.io/aws-load-balancer-cross-zone-load-balancing-enabled: 'true'
      service.beta.kubernetes.io/aws-load-balancer-type: nlb
      service.beta.kubernetes.io/aws-load-balancer-external: "true"
    external:
      enabled: true
    internal:
      enabled: true
      annotations:
        kubernetes.io/ingress.class: nginx
        service.beta.kubernetes.io/aws-load-balancer-backend-protocol: tcp
        service.beta.kubernetes.io/aws-load-balancer-cross-zone-load-balancing-enabled: 'true'
        service.beta.kubernetes.io/aws-load-balancer-type: nlb
        service.beta.kubernetes.io/aws-load-balancer-internal: "true"
  EOT
  filename = "${path.module}/override_values/ingress_nginx.yaml"
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
  filename = "${path.module}/override_values/kubeclarity.yaml"
}
