resource "null_resource" "helm_upgrade" {
  provisioner "local-exec" {
    command     = <<-EOT
      helm upgrade --install -n kube-system k8s-pod-restart-info-collector ../../addons/k8s-pod-restart-info-collector/helm --set slackWebhookUrl="${var.slack_config.slack_webhook_url}" --set clusterName="${var.eks_cluster_name}" --set slackChannel="${var.slack_config.slack_channel}"
    EOT
    interpreter = ["bash", "-c"]
  }
}

resource "null_resource" "helm_release" {
  count = 1

  provisioner "local-exec" {
    when    = destroy
    command = <<-EOT
      if helm status k8s-pod-restart-info-collector -n kube-system > /dev/null 2>&1; then
        helm uninstall k8s-pod-restart-info-collector -n kube-system
      fi
    EOT
  }
}
