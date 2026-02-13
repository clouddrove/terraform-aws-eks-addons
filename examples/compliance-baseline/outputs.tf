output "eks_cluster_name" {
  value       = var.eks_cluster_name
  description = "Cluster name used by this example"
}

output "velero_bucket_name" {
  value       = var.velero_bucket_name
  description = "Velero bucket configured for backup metadata"
}
