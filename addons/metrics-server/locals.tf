locals {
  name = "metrics-server"

  default_helm_config = {
    name                       = local.name
    chart                      = try(var.metrics_server_extra_configs.chart, local.name)
    repository                 = try(var.metrics_server_extra_configs.repository, "https://kubernetes-sigs.github.io/metrics-server/")
    version                    = try(var.metrics_server_extra_configs.version, "3.8.2")
    namespace                  = try(var.metrics_server_extra_configs.namespace, "kube-system")
    create_namespace           = try(var.metrics_server_extra_configs.create_namespace, true)
    description                = "Metric server helm Chart deployment configuration"
    timeout                    = try(var.metrics_server_extra_configs.timeout, "600")
    lint                       = try(var.metrics_server_extra_configs.lint, "false")
    repository_key_file        = try(var.metrics_server_extra_configs.repository_key_file, "")
    repository_cert_file       = try(var.metrics_server_extra_configs.repository_cert_file, "")
    repository_username        = try(var.metrics_server_extra_configs.repository_password, "")
    repository_password        = try(var.metrics_server_extra_configs.repository_password, "")
    verify                     = try(var.metrics_server_extra_configs.verify, "false")
    keyring                    = try(var.metrics_server_extra_configs.keyring, "")
    disable_webhooks           = try(var.metrics_server_extra_configs.disable_webhooks, "false")
    reuse_values               = try(var.metrics_server_extra_configs.reuse_values, "false")
    reset_values               = try(var.metrics_server_extra_configs.reset_values, "false")
    force_update               = try(var.metrics_server_extra_configs.force_update, "false")
    recreate_pods              = try(var.metrics_server_extra_configs.recreate_pods, "false")
    cleanup_on_fail            = try(var.metrics_server_extra_configs.cleanup_on_fail, "false")
    max_history                = try(var.metrics_server_extra_configs.max_history, "0")
    atomic                     = try(var.metrics_server_extra_configs.atomic, "false")
    skip_crds                  = try(var.metrics_server_extra_configs.skip_crds, "false")
    render_subchart_notes      = try(var.metrics_server_extra_configs.render_subchart_notes, "true")
    disable_openapi_validation = try(var.metrics_server_extra_configs.disable_openapi_validation, "false")
    wait                       = try(var.metrics_server_extra_configs.wait, "true")
    wait_for_jobs              = try(var.metrics_server_extra_configs.wait_for_jobs, "false")
    dependency_update          = try(var.metrics_server_extra_configs.dependency_update, "false")
    replace                    = try(var.metrics_server_extra_configs.replace, "false")
  }

  metrics_server_extra_configs = var.metrics_server_extra_configs

  helm_config = merge(
    local.default_helm_config,
    var.helm_config,
    local.metrics_server_extra_configs
  )

  argocd_gitops_config = {
    enable = true
  }
}
