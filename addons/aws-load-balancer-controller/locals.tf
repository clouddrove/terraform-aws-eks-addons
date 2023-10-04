locals {
  name = "aws-load-balancer-controller"

  default_helm_config = {
    name                       = try(var.aws_load_balancer_controller_extra_configs.name, local.name)
    chart                      = try(var.aws_load_balancer_controller_extra_configs.chart, local.name)
    repository                 = try(var.aws_load_balancer_controller_extra_configs.repository, "https://aws.github.io/eks-charts")
    version                    = try(var.aws_load_balancer_controller_extra_configs.version, "1.5.3")
    namespace                  = try(var.aws_load_balancer_controller_extra_configs.namespace, "kube-system")
    description                = "AWS Load Balancer Controller helm Chart deployment configuration"
    timeout                    = try(var.aws_load_balancer_controller_extra_configs.timeout, "600")
    lint                       = try(var.aws_load_balancer_controller_extra_configs.lint, "false")
    repository_key_file        = try(var.aws_load_balancer_controller_extra_configs.repository_key_file, "")
    repository_cert_file       = try(var.aws_load_balancer_controller_extra_configs.repository_cert_file, "")
    repository_username        = try(var.aws_load_balancer_controller_extra_configs.repository_password, "")
    repository_password        = try(var.aws_load_balancer_controller_extra_configs.repository_password, "")
    verify                     = try(var.aws_load_balancer_controller_extra_configs.verify, "false")
    keyring                    = try(var.aws_load_balancer_controller_extra_configs.keyring, "")
    disable_webhooks           = try(var.aws_load_balancer_controller_extra_configs.disable_webhooks, "false")
    reuse_values               = try(var.aws_load_balancer_controller_extra_configs.reuse_values, "false")
    reset_values               = try(var.aws_load_balancer_controller_extra_configs.reset_values, "false")
    force_update               = try(var.aws_load_balancer_controller_extra_configs.force_update, "false")
    recreate_pods              = try(var.aws_load_balancer_controller_extra_configs.recreate_pods, "false")
    cleanup_on_fail            = try(var.aws_load_balancer_controller_extra_configs.cleanup_on_fail, "false")
    max_history                = try(var.aws_load_balancer_controller_extra_configs.max_history, "0")
    atomic                     = try(var.aws_load_balancer_controller_extra_configs.atomic, "false")
    skip_crds                  = try(var.aws_load_balancer_controller_extra_configs.skip_crds, "false")
    render_subchart_notes      = try(var.aws_load_balancer_controller_extra_configs.render_subchart_notes, "true")
    disable_openapi_validation = try(var.aws_load_balancer_controller_extra_configs.disable_openapi_validation, "false")
    wait                       = try(var.aws_load_balancer_controller_extra_configs.wait, "true")
    wait_for_jobs              = try(var.aws_load_balancer_controller_extra_configs.wait_for_jobs, "false")
    dependency_update          = try(var.aws_load_balancer_controller_extra_configs.dependency_update, "false")
    replace                    = try(var.aws_load_balancer_controller_extra_configs.replace, "false")
  }

  helm_config = merge(
    local.default_helm_config,
    var.helm_config,
  )
}
