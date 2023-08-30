module "helm_addon" {
  source = "../helm"

  manage_via_gitops = var.manage_via_gitops
  helm_config       = local.helm_config
  addon_context     = var.addon_context

  set_values = [
    {
      name  = "configuration.backupStorageLocation[0].provider"
      value = "aws"
    },
    {
      name  = "configuration.volumeSnapshotLocation[0].provider"
      value = "aws"
    },
    {
      name  = "configuration.backupStorageLocation[0].config.region"
      value = data.aws_region.current.name
    },
    {
      name  = "configuration.volumeSnapshotLocation[0].config.region"
      value = data.aws_region.current.name
    }
  ]
}