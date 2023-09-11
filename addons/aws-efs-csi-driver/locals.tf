locals {
  name = "aws-efs-csi-driver"

  default_helm_config = {
    name                       = try(var.aws_efs_csi_driver_extra_configs.name, local.name)
    chart                      = try(var.aws_efs_csi_driver_extra_configs.chart, local.name)
    repository                 = try(var.aws_efs_csi_driver_extra_configs.repository, "https://kubernetes-sigs.github.io/aws-efs-csi-driver/")
    version                    = try(var.aws_efs_csi_driver_extra_configs.version, "2.4.4")
    namespace                  = try(var.aws_efs_csi_driver_extra_configs.namespace, "kube-system")
    description                = "AWS EFS CSI Driver helm Chart deployment configuration"
    timeout                    = try(var.aws_efs_csi_driver_extra_configs.timeout, "600")
    lint                       = try(var.aws_efs_csi_driver_extra_configs.lint, "false")
    repository_key_file        = try(var.aws_efs_csi_driver_extra_configs.repository_key_file, "")
    repository_cert_file       = try(var.aws_efs_csi_driver_extra_configs.repository_cert_file, "")
    repository_username        = try(var.aws_efs_csi_driver_extra_configs.repository_password, "")
    repository_password        = try(var.aws_efs_csi_driver_extra_configs.repository_password, "")
    verify                     = try(var.aws_efs_csi_driver_extra_configs.verify, "false")
    keyring                    = try(var.aws_efs_csi_driver_extra_configs.keyring, "")
    disable_webhooks           = try(var.aws_efs_csi_driver_extra_configs.disable_webhooks, "false")
    reuse_values               = try(var.aws_efs_csi_driver_extra_configs.reuse_values, "false")
    reset_values               = try(var.aws_efs_csi_driver_extra_configs.reset_values, "false")
    force_update               = try(var.aws_efs_csi_driver_extra_configs.force_update, "false")
    recreate_pods              = try(var.aws_efs_csi_driver_extra_configs.recreate_pods, "false")
    cleanup_on_fail            = try(var.aws_efs_csi_driver_extra_configs.cleanup_on_fail, "false")
    max_history                = try(var.aws_efs_csi_driver_extra_configs.max_history, "0")
    atomic                     = try(var.aws_efs_csi_driver_extra_configs.atomic, "false")
    skip_crds                  = try(var.aws_efs_csi_driver_extra_configs.skip_crds, "false")
    render_subchart_notes      = try(var.aws_efs_csi_driver_extra_configs.render_subchart_notes, "true")
    disable_openapi_validation = try(var.aws_efs_csi_driver_extra_configs.disable_openapi_validation, "false")
    wait                       = try(var.aws_efs_csi_driver_extra_configs.wait, "true")
    wait_for_jobs              = try(var.aws_efs_csi_driver_extra_configs.wait_for_jobs, "false")
    dependency_update          = try(var.aws_efs_csi_driver_extra_configs.dependency_update, "false")
    replace                    = try(var.aws_efs_csi_driver_extra_configs.replace, "false")
  }

  aws_efs_csi_driver_extra_configs = var.aws_efs_csi_driver_extra_configs

  helm_config = merge(
    local.default_helm_config,
    var.helm_config,
    local.aws_efs_csi_driver_extra_configs
  )

  image_repository = {
    "af-south-1"     = "877085696533.dkr.ecr.af-south-1.amazonaws.com"
    "ap-east-1"      = "800184023465.dkr.ecr.ap-east-1.amazonaws.com"
    "ap-northeast-1" = "602401143452.dkr.ecr.ap-northeast-1.amazonaws.com"
    "ap-northeast-2" = "602401143452.dkr.ecr.ap-northeast-2.amazonaws.com"
    "ap-northeast-3" = "602401143452.dkr.ecr.ap-northeast-3.amazonaws.com"
    "ap-south-1"     = "602401143452.dkr.ecr.ap-south-1.amazonaws.com"
    "ap-south-2"     = "900889452093.dkr.ecr.ap-south-2.amazonaws.com"
    "ap-southeast-1" = "602401143452.dkr.ecr.ap-southeast-1.amazonaws.com"
    "ap-southeast-2" = "602401143452.dkr.ecr.ap-southeast-2.amazonaws.com"
    "ap-southeast-3" = "296578399912.dkr.ecr.ap-southeast-3.amazonaws.com"
    "ap-southeast-4" = "491585149902.dkr.ecr.ap-southeast-4.amazonaws.com"
    "ca-central-1"   = "602401143452.dkr.ecr.ca-central-1.amazonaws.com"
    "cn-north-1"     = "918309763551.dkr.ecr.cn-north-1.amazonaws.com.cn"
    "cn-northwest-1" = "961992271922.dkr.ecr.cn-northwest-1.amazonaws.com.cn"
    "eu-central-1"   = "602401143452.dkr.ecr.eu-central-1.amazonaws.com"
    "eu-central-2"   = "900612956339.dkr.ecr.eu-central-2.amazonaws.com"
    "eu-north-1"     = "602401143452.dkr.ecr.eu-north-1.amazonaws.com"
    "eu-south-1"     = "590381155156.dkr.ecr.eu-south-1.amazonaws.com"
    "eu-south-2"     = "455263428931.dkr.ecr.eu-south-2.amazonaws.com"
    "eu-west-1"      = "602401143452.dkr.ecr.eu-west-1.amazonaws.com"
    "eu-west-2"      = "602401143452.dkr.ecr.eu-west-2.amazonaws.com"
    "eu-west-3"      = "602401143452.dkr.ecr.eu-west-3.amazonaws.com"
    "me-south-1"     = "558608220178.dkr.ecr.me-south-1.amazonaws.com"
    "me-central-1"   = "759879836304.dkr.ecr.me-central-1.amazonaws.com"
    "sa-east-1"      = "602401143452.dkr.ecr.sa-east-1.amazonaws.com"
    "us-east-1"      = "602401143452.dkr.ecr.us-east-1.amazonaws.com"
    "us-east-2"      = "602401143452.dkr.ecr.us-east-2.amazonaws.com"
    "us-gov-east-1"  = "151742754352.dkr.ecr.us-gov-east-1.amazonaws.com"
    "us-gov-west-1"  = "013241004608.dkr.ecr.us-gov-west-1.amazonaws.com"
    "us-west-1"      = "602401143452.dkr.ecr.us-west-1.amazonaws.com"
    "us-west-2"      = "602401143452.dkr.ecr.us-west-2.amazonaws.com    "
  }
}
