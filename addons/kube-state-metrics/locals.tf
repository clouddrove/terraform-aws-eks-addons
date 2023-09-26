locals {
  name = "kube-state-metrics"

  default_helm_config = {
    name                       = try(var.kube_state_metrics_extra_configs.name, local.name)
    chart                      = try(var.kube_state_metrics_extra_configs.chart, local.name)
    repository                 = try(var.kube_state_metrics_extra_configs.repository, "https://prometheus-community.github.io/helm-charts")
    version                    = try(var.kube_state_metrics_extra_configs.version, "5.13.0")
    namespace                  = try(var.kube_state_metrics_extra_configs.namespace, "kube-system")
    create_namespace           = try(var.kube_state_metrics_extra_configs.create_namespace, false)
    description                = "Kube-State-Metrics helm Chart deployment configuration"
    timeout                    = try(var.kube_state_metrics_extra_configs.timeout, "600")
    lint                       = try(var.kube_state_metrics_extra_configs.lint, "false")
    repository_key_file        = try(var.kube_state_metrics_extra_configs.repository_key_file, "")
    repository_cert_file       = try(var.kube_state_metrics_extra_configs.repository_cert_file, "")
    repository_username        = try(var.kube_state_metrics_extra_configs.repository_password, "")
    repository_password        = try(var.kube_state_metrics_extra_configs.repository_password, "")
    verify                     = try(var.kube_state_metrics_extra_configs.verify, "false")
    keyring                    = try(var.kube_state_metrics_extra_configs.keyring, "")
    disable_webhooks           = try(var.kube_state_metrics_extra_configs.disable_webhooks, "false")
    reuse_values               = try(var.kube_state_metrics_extra_configs.reuse_values, "false")
    reset_values               = try(var.kube_state_metrics_extra_configs.reset_values, "false")
    force_update               = try(var.kube_state_metrics_extra_configs.force_update, "false")
    recreate_pods              = try(var.kube_state_metrics_extra_configs.recreate_pods, "false")
    cleanup_on_fail            = try(var.kube_state_metrics_extra_configs.cleanup_on_fail, "false")
    max_history                = try(var.kube_state_metrics_extra_configs.max_history, "0")
    atomic                     = try(var.kube_state_metrics_extra_configs.atomic, "false")
    skip_crds                  = try(var.kube_state_metrics_extra_configs.skip_crds, "false")
    render_subchart_notes      = try(var.kube_state_metrics_extra_configs.render_subchart_notes, "true")
    disable_openapi_validation = try(var.kube_state_metrics_extra_configs.disable_openapi_validation, "false")
    wait                       = try(var.kube_state_metrics_extra_configs.wait, "true")
    wait_for_jobs              = try(var.kube_state_metrics_extra_configs.wait_for_jobs, "false")
    dependency_update          = try(var.kube_state_metrics_extra_configs.dependency_update, "false")
    replace                    = try(var.kube_state_metrics_extra_configs.replace, "false")
  }

  kube_state_metrics_extra_configs = var.kube_state_metrics_extra_configs

  helm_config = merge(
    local.default_helm_config,
    var.helm_config,
    local.kube_state_metrics_extra_configs
  )
}
