locals {
  name = "grafana"

  default_helm_config = {
    name                       = try(var.grafana_extra_configs.name, local.name)
    chart                      = try(var.grafana_extra_configs.chart, local.name)
    repository                 = try(var.grafana_extra_configs.repository, "https://grafana.github.io/helm-charts")
    version                    = try(var.grafana_extra_configs.version, "7.0.2")
    namespace                  = try(var.grafana_extra_configs.namespace, "monitoring")
    create_namespace           = try(var.grafana_extra_configs.create_namespace, true)
    description                = "Grafana helm Chart deployment configuration"
    timeout                    = try(var.grafana_extra_configs.timeout, "600")
    lint                       = try(var.grafana_extra_configs.lint, "false")
    repository_key_file        = try(var.grafana_extra_configs.repository_key_file, "")
    repository_cert_file       = try(var.grafana_extra_configs.repository_cert_file, "")
    repository_username        = try(var.grafana_extra_configs.repository_username, "")
    repository_password        = try(var.grafana_extra_configs.repository_password, "")
    verify                     = try(var.grafana_extra_configs.verify, "false")
    keyring                    = try(var.grafana_extra_configs.keyring, null)
    disable_webhooks           = try(var.grafana_extra_configs.disable_webhooks, "false")
    reuse_values               = try(var.grafana_extra_configs.reuse_values, "false")
    reset_values               = try(var.grafana_extra_configs.reset_values, "false")
    force_update               = try(var.grafana_extra_configs.force_update, "false")
    recreate_pods              = try(var.grafana_extra_configs.recreate_pods, "false")
    cleanup_on_fail            = try(var.grafana_extra_configs.cleanup_on_fail, "false")
    max_history                = try(var.grafana_extra_configs.max_history, "0")
    atomic                     = try(var.grafana_extra_configs.atomic, "false")
    skip_crds                  = try(var.grafana_extra_configs.skip_crds, "false")
    render_subchart_notes      = try(var.grafana_extra_configs.render_subchart_notes, "true")
    disable_openapi_validation = try(var.grafana_extra_configs.disable_openapi_validation, "false")
    wait                       = try(var.grafana_extra_configs.wait, "true")
    wait_for_jobs              = try(var.grafana_extra_configs.wait_for_jobs, "false")
    dependency_update          = try(var.grafana_extra_configs.dependency_update, "false")
    replace                    = try(var.grafana_extra_configs.replace, "false")
  }

  helm_config = merge(
    local.default_helm_config,
    var.helm_config
  )
}