# ------------------------------------------------------------------------------
# Outputs
# ------------------------------------------------------------------------------
output "module_path" {
  value = "${path.module}"
}
output "cwd" {
  value = "${path.cwd}"
}
output "KUBE_CONFIG_PATH" {
  value = "~/.kube/config"
}
