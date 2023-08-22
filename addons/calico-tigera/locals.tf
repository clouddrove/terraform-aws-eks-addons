locals {
  name = "tigera-operator"

  default_helm_config = {
    name                       = local.name
    chart                      = local.name
    repository                 = try(var.calico_tigera_extra_configs.repository, "https://docs.tigera.io/calico/charts")
    version                    = try(var.calico_tigera_extra_configs.version, "v3.26.1")
    namespace                  = try(var.calico_tigera_extra_configs.namespace, "calico-system")
    create_namespace           = try(var.calico_tigera_extra_configs.create_namespace, true)
    description                = "Calico helm Chart deployment configuration"
    timeout                    = try(var.calico_tigera_extra_configs.timeout, "600")
    lint                       = try(var.calico_tigera_extra_configs.lint, "false")
    repository_key_file        = try(var.calico_tigera_extra_configs.repository_key_file, "")
    repository_cert_file       = try(var.calico_tigera_extra_configs.repository_cert_file, "")
    repository_username        = try(var.calico_tigera_extra_configs.repository_password, "")
    repository_password        = try(var.calico_tigera_extra_configs.repository_password, "")
    verify                     = try(var.calico_tigera_extra_configs.verify, "false")
    keyring                    = try(var.calico_tigera_extra_configs.keyring, "")
    disable_webhooks           = try(var.calico_tigera_extra_configs.disable_webhooks, "false")
    reuse_values               = try(var.calico_tigera_extra_configs.reuse_values, "false")
    reset_values               = try(var.calico_tigera_extra_configs.reset_values, "false")
    force_update               = try(var.calico_tigera_extra_configs.force_update, "false")
    recreate_pods              = try(var.calico_tigera_extra_configs.recreate_pods, "false")
    cleanup_on_fail            = try(var.calico_tigera_extra_configs.cleanup_on_fail, "false")
    max_history                = try(var.calico_tigera_extra_configs.max_history, "0")
    atomic                     = try(var.calico_tigera_extra_configs.atomic, "false")
    skip_crds                  = try(var.calico_tigera_extra_configs.skip_crds, "false")
    render_subchart_notes      = try(var.calico_tigera_extra_configs.render_subchart_notes, "true")
    disable_openapi_validation = try(var.calico_tigera_extra_configs.disable_openapi_validation, "false")
    wait                       = try(var.calico_tigera_extra_configs.wait, "true")
    wait_for_jobs              = try(var.calico_tigera_extra_configs.wait_for_jobs, "false")
    dependency_update          = try(var.calico_tigera_extra_configs.dependency_update, "false")
    replace                    = try(var.calico_tigera_extra_configs.replace, "false")
  }

  calico_tigera_extra_configs = var.calico_tigera_extra_configs

  helm_config = merge(
    local.default_helm_config,
    var.helm_config,
    local.calico_tigera_extra_configs
  )

  argocd_gitops_config = {
    enable = true
  }

}