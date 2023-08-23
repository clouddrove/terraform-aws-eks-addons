# ------------------------------------------------------------------------------
# Outputs
# ------------------------------------------------------------------------------
output "cluster_name" {
  value = module.eks.cluster_name
}

output "region" {
  value = local.region
}