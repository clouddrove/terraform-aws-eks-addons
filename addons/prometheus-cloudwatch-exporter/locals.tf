locals {
  name = "prometheus-cloudwatch-exporter"

  default_helm_config = {
    name                       = try(var.prometheus_cloudwatch_exporter_extra_configs.name, local.name)
    chart                      = try(var.prometheus_cloudwatch_exporter_extra_configs.chart, local.name)
    repository                 = try(var.prometheus_cloudwatch_exporter_extra_configs.repository, "https://prometheus-community.github.io/helm-charts")
    version                    = try(var.prometheus_cloudwatch_exporter_extra_configs.version, "0.25.2")
    namespace                  = try(var.prometheus_cloudwatch_exporter_extra_configs.namespace, "monitoring")
    create_namespace           = try(var.prometheus_cloudwatch_exporter_extra_configs.create_namespace, true)
    description                = "Prometheus Cloudwatch-Exporter helm Chart deployment configuration"
    timeout                    = try(var.prometheus_cloudwatch_exporter_extra_configs.timeout, "600")
    lint                       = try(var.prometheus_cloudwatch_exporter_extra_configs.lint, "false")
    repository_key_file        = try(var.prometheus_cloudwatch_exporter_extra_configs.repository_key_file, "")
    repository_cert_file       = try(var.prometheus_cloudwatch_exporter_extra_configs.repository_cert_file, "")
    repository_username        = try(var.prometheus_cloudwatch_exporter_extra_configs.repository_username, "")
    repository_password        = try(var.prometheus_cloudwatch_exporter_extra_configs.repository_password, "")
    verify                     = try(var.prometheus_cloudwatch_exporter_extra_configs.verify, "false")
    keyring                    = try(var.prometheus_cloudwatch_exporter_extra_configs.keyring, "")
    disable_webhooks           = try(var.prometheus_cloudwatch_exporter_extra_configs.disable_webhooks, "false")
    reuse_values               = try(var.prometheus_cloudwatch_exporter_extra_configs.reuse_values, "false")
    reset_values               = try(var.prometheus_cloudwatch_exporter_extra_configs.reset_values, "false")
    force_update               = try(var.prometheus_cloudwatch_exporter_extra_configs.force_update, "false")
    recreate_pods              = try(var.prometheus_cloudwatch_exporter_extra_configs.recreate_pods, "false")
    cleanup_on_fail            = try(var.prometheus_cloudwatch_exporter_extra_configs.cleanup_on_fail, "false")
    max_history                = try(var.prometheus_cloudwatch_exporter_extra_configs.max_history, "0")
    atomic                     = try(var.prometheus_cloudwatch_exporter_extra_configs.atomic, "false")
    skip_crds                  = try(var.prometheus_cloudwatch_exporter_extra_configs.skip_crds, "false")
    render_subchart_notes      = try(var.prometheus_cloudwatch_exporter_extra_configs.render_subchart_notes, "true")
    disable_openapi_validation = try(var.prometheus_cloudwatch_exporter_extra_configs.disable_openapi_validation, "false")
    wait                       = try(var.prometheus_cloudwatch_exporter_extra_configs.wait, "true")
    wait_for_jobs              = try(var.prometheus_cloudwatch_exporter_extra_configs.wait_for_jobs, "false")
    dependency_update          = try(var.prometheus_cloudwatch_exporter_extra_configs.dependency_update, "false")
    replace                    = try(var.prometheus_cloudwatch_exporter_extra_configs.replace, "false")
  }

  helm_config = merge(
    local.default_helm_config,
    var.helm_config
  )

  role_name   = coalesce(var.prometheus_cloudwatch_exporter_extra_configs.role_name, "${local.name}-${var.eks_cluster_name}-role")
  policy_name = "${local.name}-${var.eks_cluster_name}-policy"
}
