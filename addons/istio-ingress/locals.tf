locals {
  istio_base = {
    helm_config = {
      name             = try(var.istio_ingress_extra_configs.istiobase_release_name, "base")
      chart            = "base"
      repository       = "https://istio-release.storage.googleapis.com/charts"
      version          = "1.18.0"
      namespace        = try(var.istio_ingress_extra_configs.namespace, "istio-system")
      create_namespace = try(var.istio_ingress_extra_configs.create_namespace, true)
      description      = "Istio helm Chart deployment configuration"
    }
  }

  istiod = {
    helm_config = {
      name             = try(var.istio_ingress_extra_configs.istiod_release_name, "istiod")
      chart            = "istiod"
      repository       = "https://istio-release.storage.googleapis.com/charts"
      version          = "1.18.0"
      namespace        = try(var.istio_ingress_extra_configs.namespace, "istio-system")
      create_namespace = try(var.istio_ingress_extra_configs.create_namespace, true)
      description      = "Istio helm Chart deployment configuration"
    }
  }

  default_helm_config = {
    name                       = try(var.istio_ingress_extra_configs.name, "istio-ingressgateway")
    chart                      = try(var.istio_ingress_extra_configs.chart, "gateway")
    repository                 = try(var.istio_ingress_extra_configs.repository, "https://istio-release.storage.googleapis.com/charts")
    version                    = try(var.istio_ingress_extra_configs.version, "1.18.0")
    namespace                  = try(var.istio_ingress_extra_configs.namespace, "istio-system")
    create_namespace           = try(var.istio_ingress_extra_configs.create_namespace, true)
    description                = "Istio Ingress helm Chart deployment configuration"
    timeout                    = try(var.istio_ingress_extra_configs.timeout, "600")
    lint                       = try(var.istio_ingress_extra_configs.lint, "false")
    repository_key_file        = try(var.istio_ingress_extra_configs.repository_key_file, "")
    repository_cert_file       = try(var.istio_ingress_extra_configs.repository_cert_file, "")
    repository_username        = try(var.istio_ingress_extra_configs.repository_password, "")
    repository_password        = try(var.istio_ingress_extra_configs.repository_password, "")
    verify                     = try(var.istio_ingress_extra_configs.verify, "false")
    keyring                    = try(var.istio_ingress_extra_configs.keyring, "")
    disable_webhooks           = try(var.istio_ingress_extra_configs.disable_webhooks, "false")
    reuse_values               = try(var.istio_ingress_extra_configs.reuse_values, "false")
    reset_values               = try(var.istio_ingress_extra_configs.reset_values, "false")
    force_update               = try(var.istio_ingress_extra_configs.force_update, "false")
    recreate_pods              = try(var.istio_ingress_extra_configs.recreate_pods, "false")
    cleanup_on_fail            = try(var.istio_ingress_extra_configs.cleanup_on_fail, "false")
    max_history                = try(var.istio_ingress_extra_configs.max_history, "0")
    atomic                     = try(var.istio_ingress_extra_configs.atomic, "false")
    skip_crds                  = try(var.istio_ingress_extra_configs.skip_crds, "false")
    render_subchart_notes      = try(var.istio_ingress_extra_configs.render_subchart_notes, "true")
    disable_openapi_validation = try(var.istio_ingress_extra_configs.disable_openapi_validation, "false")
    wait                       = try(var.istio_ingress_extra_configs.wait, "true")
    wait_for_jobs              = try(var.istio_ingress_extra_configs.wait_for_jobs, "false")
    dependency_update          = try(var.istio_ingress_extra_configs.dependency_update, "false")
    replace                    = try(var.istio_ingress_extra_configs.replace, "false")
  }

  helm_config = merge(
    local.default_helm_config,
    var.helm_config,
  )
}
