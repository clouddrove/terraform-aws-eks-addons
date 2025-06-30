# ------------------------------------------------------------------------------
# Resources
# ------------------------------------------------------------------------------

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "6.0.1"

  name = "${local.name}-vpc"
  cidr = local.vpc_cidr

  azs              = local.azs
  private_subnets  = [for k, v in local.azs : cidrsubnet(local.vpc_cidr, 8, k)]
  public_subnets   = [for k, v in local.azs : cidrsubnet(local.vpc_cidr, 8, k + 4)]
  database_subnets = [for k, v in local.azs : cidrsubnet(local.vpc_cidr, 8, k + 8)]

  enable_nat_gateway           = true
  single_nat_gateway           = true
  create_database_subnet_group = false

  public_subnet_tags = {
    "kubernetes.io/role/elb" = "1"
  }

  private_subnet_tags = {
    "kubernetes.io/role/internal-elb" = 1
  }

  tags = local.tags
}

###############################################################################
# AWS EKS
###############################################################################

module "eks" {
  source  = "clouddrove/eks/aws"
  version = "1.4.4"
  enabled = true

  name                   = local.name
  kubernetes_version     = "1.31"
  endpoint_public_access = true

  vpc_id     = module.vpc.vpc_id
  subnet_ids = module.vpc.private_subnets

  allowed_cidr_blocks = [local.vpc_cidr]

  # AWS Managed Node Group
  # Node Groups Defaults Values It will Work all Node Groups
  managed_node_group_defaults = {


    iam_role_additional_policies = {
      policy_arn = aws_iam_policy.node_additional.arn
    }
    tags = {
      "kubernetes.io/cluster/${module.eks.cluster_name}"  = "shared"
      "karpenter.sh/discovery/${module.eks.cluster_name}" = module.eks.cluster_name
    }
    block_device_mappings = {
      xvda = {
        device_name = "/dev/xvda"
        ebs = {
          volume_size = 50
          volume_type = "gp3"
          iops        = 3000
          throughput  = 150
          encrypted   = true
        }
      }
    }
  }
  managed_node_group = {

    critical = {
      name           = "critical"
      capacity_type  = "ON_DEMAND"
      min_size       = 1
      max_size       = 2
      desired_size   = 2
      instance_types = ["t3.medium"]

    }

    application = {
      name                 = "application"
      capacity_type        = "SPOT"
      min_size             = 1
      max_size             = 2
      desired_size         = 1
      force_update_version = true
      instance_types       = ["t3.medium"]
    }
  }

  apply_config_map_aws_auth = true
  map_additional_iam_users = [
    {
      userarn  = "arn:aws:iam::123456789:user/hello@clouddrove.com"
      username = "hello@clouddrove.com"
      groups   = ["system:masters"]
    }
  ]
  addons = []
  tags   = local.tags
}

################################################################################
# EKS Supporting Resources
################################################################################
module "vpc_cni_irsa" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-role-for-service-accounts-eks"
  version = "~> 5.0"

  role_name_prefix      = "VPC-CNI-IRSA"
  attach_vpc_cni_policy = true
  vpc_cni_enable_ipv6   = true

  oidc_providers = {
    main = {
      provider_arn               = module.eks.oidc_provider_arn
      namespace_service_accounts = ["kube-system:aws-node"]
    }
  }

  tags = local.tags
}

resource "aws_iam_policy" "node_additional" {
  name        = "${local.name}-additional"
  description = "Example usage of node additional policy"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "ec2:Describe*"
        ]
        Effect   = "Allow"
        Resource = "*"
      },
    ]
  })
  tags = local.tags
}

module "addons" {
  source = "../../"

  depends_on       = [module.eks]
  eks_cluster_name = module.eks.cluster_name

  # -- Enable Addons
  metrics_server                 = true
  cluster_autoscaler             = true
  aws_load_balancer_controller   = true
  aws_node_termination_handler   = true
  aws_efs_csi_driver             = true
  aws_ebs_csi_driver             = true
  kube_state_metrics             = true
  karpenter                      = false # -- Set to `false` or comment line to Uninstall Karpenter if installed using terraform.
  calico_tigera                  = true
  new_relic                      = true
  kubeclarity                    = true
  ingress_nginx                  = true
  fluent_bit                     = true
  velero                         = true
  keda                           = true
  certification_manager          = true
  loki                           = true
  jaeger                         = true
  filebeat                       = true
  reloader                       = true
  external_dns                   = true
  redis                          = true
  actions_runner_controller      = true
  prometheus                     = true
  prometheus_cloudwatch_exporter = true
  aws_xray                       = true

  # Grafana Deployment
  grafana               = true
  grafana_helm_config   = { values = [file("./config/grafana/override-grafana.yaml")] }
  grafana_manifests     = var.grafana_manifests
  grafana_extra_configs = var.grafana_extra_configs

  # -- Addons with mandatory variable
  istio_ingress    = true
  istio_manifests  = var.istio_manifests
  kiali_server     = true
  kiali_manifests  = var.kiali_manifests
  external_secrets = true

  # -- Path of override-values.yaml file
  metrics_server_helm_config                     = { values = [file("./config/override-metrics-server.yaml")] }
  cluster_autoscaler_helm_config                 = { values = [file("./config/override-cluster-autoscaler.yaml")] }
  karpenter_helm_config                          = { values = [file("./config/override-karpenter.yaml")] }
  aws_load_balancer_controller_helm_config       = { values = [file("./config/override-aws-load-balancer-controller.yaml")] }
  aws_node_termination_handler_helm_config       = { values = [file("./config/override-aws-node-termination-handler.yaml")] }
  aws_efs_csi_driver_helm_config                 = { values = [file("./config/override-aws-efs-csi-driver.yaml")] }
  aws_ebs_csi_driver_helm_config                 = { values = [file("./config/override-aws-ebs-csi-driver.yaml")] }
  calico_tigera_helm_config                      = { values = [file("./config/calico-tigera-values.yaml")] }
  istio_ingress_helm_config                      = { values = [file("./config/istio/override-values.yaml")] }
  kiali_server_helm_config                       = { values = [file("./config/kiali/override-values.yaml")] }
  external_secrets_helm_config                   = { values = [file("./config/external-secret/override-values.yaml")] }
  ingress_nginx_helm_config                      = { values = [file("./config/override-ingress-nginx.yaml")] }
  kubeclarity_helm_config                        = { values = [file("./config/override-kubeclarity.yaml")] }
  fluent_bit_helm_config                         = { values = [file("./config/override-fluent-bit.yaml")] }
  velero_helm_config                             = { values = [file("./config/override-velero.yaml")] }
  new_relic_helm_config                          = { values = [file("./config/override-new-relic.yaml")] }
  kube_state_metrics_helm_config                 = { values = [file("./config/override-kube-state-matrics.yaml")] }
  keda_helm_config                               = { values = [file("./config/keda/override-keda.yaml")] }
  certification_manager_helm_config              = { values = [file("./config/override-certification-manager.yaml")] }
  loki_helm_config                               = { values = [file("./config/override-loki.yaml")] }
  jaeger_helm_config                             = { values = [file("./config/override-jaeger.yaml")] }
  filebeat_helm_config                           = { values = [file("./config/override-filebeat.yaml")] }
  reloader_helm_config                           = { values = [file("./config/reloader/override-reloader.yaml")] }
  external_dns_helm_config                       = { values = [file("./config/override-external-dns.yaml")] }
  redis_helm_config                              = { values = [file("./config/override-redis.yaml")] }
  actions_runner_controller_helm_config          = { values = [file("./config/override-actions-runner-controller.yaml")] }
  prometheus_helm_config                         = { values = [file("./config/override-prometheus.yaml")] }
  prometheus_cloudwatch_exporter_helm_config     = { values = [file("./config/prometheus-cloudwatch-exporter/override-prometheus-cloudwatch-exporter-controller.yaml")] }
  prometheus_cloudwatch_exporter_secret_manifest = file("./config/prometheus-cloudwatch-exporter/secret.yaml") # Uncomment this to use Secret Based Authentication and Update Secret manifest with real credentials
  aws_xray_helm_config                           = { values = [file("./config/aws_xray-values.yaml")] }

  # -- Override Helm Release attributes
  metrics_server_extra_configs               = var.metrics_server_extra_configs
  cluster_autoscaler_extra_configs           = var.cluster_autoscaler_extra_configs
  karpenter_extra_configs                    = var.karpenter_extra_configs
  aws_load_balancer_controller_extra_configs = var.aws_load_balancer_controller_extra_configs
  aws_node_termination_handler_extra_configs = var.aws_node_termination_handler_extra_configs
  aws_efs_csi_driver_extra_configs           = var.aws_efs_csi_driver_extra_configs
  aws_ebs_csi_driver_extra_configs           = var.aws_ebs_csi_driver_extra_configs
  calico_tigera_extra_configs                = var.calico_tigera_extra_configs
  istio_ingress_extra_configs = {
    name             = "istio-ingress"
    namespace        = "istio-system"
    create_namespace = true
    istiod = {
      values = [file("./config/istio/istiod_override.yaml")]
    }
    istio_base = {
      values = [file("./config/istio/istio_base_override.yaml")]
    }
  }
  kiali_server_extra_configs                   = var.kiali_server_extra_configs
  ingress_nginx_extra_configs                  = var.ingress_nginx_extra_configs
  kubeclarity_extra_configs                    = var.kubeclarity_extra_configs
  fluent_bit_extra_configs                     = var.fluent_bit_extra_configs
  velero_extra_configs                         = var.velero_extra_configs
  new_relic_extra_configs                      = var.new_relic_extra_configs
  kube_state_metrics_extra_configs             = var.kube_state_metrics_extra_configs
  keda_extra_configs                           = var.keda_extra_configs
  certification_manager_extra_configs          = var.certification_manager_extra_configs
  loki_extra_configs                           = var.loki_extra_configs
  jaeger_extra_configs                         = var.jaeger_extra_configs
  external_secrets_extra_configs               = var.external_secrets_extra_configs
  filebeat_extra_configs                       = var.filebeat_extra_configs
  reloader_extra_configs                       = var.reloader_extra_configs
  external_dns_extra_configs                   = var.external_dns_extra_configs
  redis_extra_configs                          = var.redis_extra_configs
  actions_runner_controller_extra_configs      = var.actions_runner_controller_extra_configs
  prometheus_extra_configs                     = var.prometheus_extra_configs
  prometheus_cloudwatch_exporter_extra_configs = var.prometheus_cloudwatch_exporter_extra_configs
  aws_xray_extra_configs                       = var.aws_xray_extra_configs

  # -- Custom IAM Policy Json for Addon's ServiceAccount
  cluster_autoscaler_iampolicy_json_content = file("./custom-iam-policies/cluster-autoscaler.json")
  external_secrets_iampolicy_json_content   = file("./custom-iam-policies/external-secrets.json")
}

module "addons-internal" {
  source = "../../"

  depends_on       = [module.eks]
  eks_cluster_name = module.eks.cluster_name

  istio_ingress               = true
  istio_manifests             = var.istio_manifests_internal
  istio_ingress_extra_configs = var.istio_ingress_extra_configs_internal
}
