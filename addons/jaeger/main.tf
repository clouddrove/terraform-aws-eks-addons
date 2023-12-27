module "cassandra" {
  count  = try(var.jaeger_extra_configs.enable_cassandra, false) ? 1 : 0
  source = "../helm"

  manage_via_gitops = var.manage_via_gitops
  helm_config       = local.cassandra.helm_config
  addon_context     = var.addon_context
}

module "kafka" {
  count  = try(var.jaeger_extra_configs.enable_kafka, false) ? 1 : 0
  source = "../helm"

  manage_via_gitops = var.manage_via_gitops
  helm_config       = local.kafka.helm_config
  addon_context     = var.addon_context
}

module "jaeger" {
  source = "../helm"

  manage_via_gitops = var.manage_via_gitops
  helm_config       = local.helm_config
  addon_context     = var.addon_context

  depends_on = [
    module.cassandra,
    module.kafka
  ]
}