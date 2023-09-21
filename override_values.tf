#-----------METRIC SERVER--------------------
resource "local_file" "metrics_server_helm_config" {
  count    = var.metrics_server && (var.metrics_server_helm_config == null) ? 1 : 0
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
  count    = var.cluster_autoscaler && (var.cluster_autoscaler_helm_config == null) ? 1 : 0
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
  count    = var.aws_load_balancer_controller && (var.aws_load_balancer_controller_helm_config == null) ? 1 : 0
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
  count    = var.aws_node_termination_handler && (var.aws_node_termination_handler_helm_config == null) ? 1 : 0
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
  count    = var.aws_efs_csi_driver && (var.aws_efs_csi_driver_helm_config == null) ? 1 : 0
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
  count    = var.aws_ebs_csi_driver && (var.aws_ebs_csi_driver_helm_config == null) ? 1 : 0
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
  count    = var.karpenter && (var.karpenter_helm_config == null) ? 1 : 0
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
  count    = var.istio_ingress && (var.istio_ingress_helm_config == null) ? 1 : 0
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
  count    = var.kiali_server && (var.kiali_server_helm_config == null) ? 1 : 0
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
  count    = var.calico_tigera && (var.calico_tigera_helm_config == null) ? 1 : 0
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
  count    = var.external_secrets && (var.external_secrets_helm_config == null) ? 1 : 0
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
  count    = var.ingress_nginx && (var.ingress_nginx_helm_config == null) ? 1 : 0
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
  count    = var.kubeclarity && (var.kubeclarity_helm_config == null) ? 1 : 0
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

#-----------FLUENT-BIT -----------------------
resource "local_file" "fluent_bit_helm_config" {
  count    = var.fluent_bit && (var.fluent_bit_helm_config == null) ? 1 : 0
  content  = <<EOT
## -- Node affinity for particular node in which labels key is "Infra-Services" and value is "true"
affinity:
  nodeAffinity:
    requiredDuringSchedulingIgnoredDuringExecution:
      nodeSelectorTerms:
      - matchExpressions:
        - key: "eks.amazonaws.com/nodegroup"
          operator: In
          values:
          - "critical"


## -- Using limits and requests
resources:
  limits:
    cpu: 150m
    memory: 150Mi
  requests:
    cpu: 100m
    memory: 90Mi

podAnnotations:
  co.elastic.logs/enabled: "true"


# -- EKS Cluster Details
eks_configs:
  aws_region: "us-east-1"
  cluster_name: "helm-addons-cluster"


# -- Configuration to use Amazon CloudWatch LogGroup for logs having word `application` in it.
config:
  service: |
    [SERVICE]
        Flush                     5
        Grace                     30
        Log_Level                 info
        Daemon                    off
        Parsers_File              parsers.conf
        HTTP_Server               On
        HTTP_Listen               0.0.0.0
        HTTP_Port                 {{ .Values.metricsPort }}
        storage.path              /var/fluent-bit/state/flb-storage/
        storage.sync              normal
        storage.checksum          off
        storage.backlog.mem_limit 5M

  inputs: |
    [INPUT]
        Name                tail
        Tag                 application.*
        Path                /var/log/containers/*.log
        multiline.parser    docker, cri
        Mem_Buf_Limit       50MB
        Skip_Long_Lines     On

    [INPUT]
        Name                tail
        Tag                 application.*
        Path                /var/log/containers/fluent-bit*
        multiline.parser    docker, cri
        Mem_Buf_Limit       5MB
        Skip_Long_Lines     On

    [INPUT]
        Name                tail
        Tag                 application.*
        Path                /var/log/containers/cloudwatch-agent*
        multiline.parser    docker, cri
        Mem_Buf_Limit       5MB
        Skip_Long_Lines     On

  filters: |
    [FILTER]
        Name                kubernetes
        Match               application.*
        Merge_Log           On
        K8S-Logging.Parser  On
        K8S-Logging.Exclude On

  outputs: |
    [OUTPUT]
        Name                cloudwatch_logs
        Match               application.*
        region              {{ .Values.eks_configs.region }}
        log_group_name      /aws/containerinsights/{{ .Values.eks_configs.cluster_name }}/application
        auto_create_group   true
        extra_user_agent    container-insights
        log_stream_prefix   eks-

  EOT
  filename = "${path.module}/override_values/fluentbit.yaml"
}

#----------- NEW RELIC AGENT ----------------
resource "local_file" "new_relic_helm_config" {
  count    = var.new_relic && (var.new_relic_helm_config == null) ? 1 : 0
  content  = <<EOT
global:  
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
  EOT
  filename = "${path.module}/override_vales/new_relic.yaml"
}

#-----------VELERO -----------------------
resource "local_file" "velero_helm_config" {
  count    = var.velero && (var.velero_helm_config == null) ? 1 : 0
  content  = <<EOT
# -- Init containers to add to the Velero deployment's pod spec. At least one plugin provider image is required. If the value is a string then it is evaluated as a template.
initContainers:
  - name: velero-plugin-for-aws
    image: velero/velero-plugin-for-aws:v1.7.0
    imagePullPolicy: IfNotPresent
    volumeMounts:
      - mountPath: /target
        name: plugins

# -- Parameters for the `default` BackupStorageLocation and VolumeSnapshotLocation, and additional server settings.
configuration:
  backupStorageLocation:
  - name: aws
    default: "true"
    provider: aws        
 
  volumeSnapshotLocation:
  - name: aws
    provider: aws
    config:
      region: "us-east-1"


# Info about the secret to be used by the Velero deployment, which
# should contain credentials for the cloud provider IAM account you've
# set up for Velero.
credentials:
  useSecret: false
  secretContents: {}


# Whether to deploy the node-agent daemonset.
deployNodeAgent: true
nodeAgent:
  podVolumePath: /var/lib/kubelet/pods
  privileged: true             
  EOT
  filename = "${path.module}/override_values/velero.yaml"
}
