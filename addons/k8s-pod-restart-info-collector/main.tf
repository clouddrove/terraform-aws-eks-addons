resource "null_resource" "helm_upgrade" {
  provisioner "local-exec" {
    command = <<-EOT
      helm upgrade --install k8s-pod-restart-info-collector ../../addons/k8s-pod-restart-info-collector/helm --set slackWebhookUrl="${var.slack_config.slack_webhook_url}" --set clusterName="${var.eks_cluster_name}" --set slackChannel="${var.slack_config.slack_channel}"
    EOT
    interpreter = ["bash", "-c"]
  }
}

