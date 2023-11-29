locals {
  enable_manifest = try(var.cassandra_extra_configs.manifest_deployment, true)
}

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

  manage_via_gitops = local.enable_manifest
  helm_config       = local.helm_config
  addon_context     = var.addon_context

  depends_on = [
    module.cassandra,
    module.kafka
  ]
}

# Jaeger Deployment using manifest file
resource "kubectl_manifest" "jager_manifest" {
  count      = local.enable_manifest ? 1 : 0
  depends_on = [module.jaeger]
  yaml_body  = try(file(var.jaeger_extra_manifests.jaeger_manifest[count.index]), file("./config/manifest/jaeger.yaml"))
}