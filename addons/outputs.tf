output "metrics_server" {
  description = "Map of attributes of the Helm release and IRSA created"
  value       = try(module.metrics_server[0], null)
}
