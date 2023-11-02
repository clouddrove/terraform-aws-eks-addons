module "cassandra" {
  source = "../helm"

  manage_via_gitops = var.manage_via_gitops
  helm_config       = local.cassandra.helm_config
  addon_context     = var.addon_context
}

module "kafka" {
  count  = var.enable_kafka ? 1 : 0
  source = "../helm"

  manage_via_gitops = var.manage_via_gitops
  helm_config       = local.kafka.helm_config
  addon_context     = var.addon_context
}

module "jaeger" {
  count = var.enable_cassandra ? 1 : 0
  source = "../helm"

  manage_via_gitops = var.manage_via_gitops
  helm_config       = local.helm_config
  addon_context     = var.addon_context

  depends_on = [
    module.cassandra,
    module.kafka
  ]
}