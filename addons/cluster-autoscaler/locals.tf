locals {
  name = "cluster-autoscaler"

  default_helm_config = {
    name                       = local.name
    chart                      = local.name
    repository                 = try(var.cluster_autoscaler_extra_configs.repository, "https://kubernetes.github.io/autoscaler")
    version                    = try(var.cluster_autoscaler_extra_configs.version, "9.29.0")
    namespace                  = try(var.cluster_autoscaler_extra_configs.namespace, "kube-system")
    description                = "Cluster Autoscaler helm Chart deployment configuration"
    timeout                    = try(var.cluster_autoscaler_extra_configs.timeout, "600")
    lint                       = try(var.cluster_autoscaler_extra_configs.lint, "false")
    repository_key_file        = try(var.cluster_autoscaler_extra_configs.repository_key_file, "")
    repository_cert_file       = try(var.cluster_autoscaler_extra_configs.repository_cert_file, "")
    repository_username        = try(var.cluster_autoscaler_extra_configs.repository_password, "")
    repository_password        = try(var.cluster_autoscaler_extra_configs.repository_password, "")
    verify                     = try(var.cluster_autoscaler_extra_configs.verify, "false")
    keyring                    = try(var.cluster_autoscaler_extra_configs.keyring, "")
    disable_webhooks           = try(var.cluster_autoscaler_extra_configs.disable_webhooks, "false")
    reuse_values               = try(var.cluster_autoscaler_extra_configs.reuse_values, "false")
    reset_values               = try(var.cluster_autoscaler_extra_configs.reset_values, "false")
    force_update               = try(var.cluster_autoscaler_extra_configs.force_update, "false")
    recreate_pods              = try(var.cluster_autoscaler_extra_configs.recreate_pods, "false")
    cleanup_on_fail            = try(var.cluster_autoscaler_extra_configs.cleanup_on_fail, "false")
    max_history                = try(var.cluster_autoscaler_extra_configs.max_history, "0")
    atomic                     = try(var.cluster_autoscaler_extra_configs.atomic, "false")
    skip_crds                  = try(var.cluster_autoscaler_extra_configs.skip_crds, "false")
    render_subchart_notes      = try(var.cluster_autoscaler_extra_configs.render_subchart_notes, "true")
    disable_openapi_validation = try(var.cluster_autoscaler_extra_configs.disable_openapi_validation, "false")
    wait                       = try(var.cluster_autoscaler_extra_configs.wait, "true")
    wait_for_jobs              = try(var.cluster_autoscaler_extra_configs.wait_for_jobs, "false")
    dependency_update          = try(var.cluster_autoscaler_extra_configs.dependency_update, "false")
    replace                    = try(var.cluster_autoscaler_extra_configs.replace, "false")
  }

  cluster_autoscaler_extra_configs = var.cluster_autoscaler_extra_configs

  helm_config = merge(
    local.default_helm_config,
    var.helm_config,
    local.cluster_autoscaler_extra_configs
  )

  argocd_gitops_config = {
    enable = true
  }
}
