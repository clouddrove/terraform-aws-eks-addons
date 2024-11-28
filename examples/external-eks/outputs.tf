# ------------------------------------------------------------------------------
# Outputs
# ------------------------------------------------------------------------------

output "update_kubeconfig" {
  value = "aws eks update-kubeconfig --name ${local.name} --region ${local.region}"
}

output "velero_post_installation" {
  value = indent(2, "Once velero server is up and running you need the client before you can use it - \n  1. wget https://github.com/vmware-tanzu/velero/releases/download/v1.11.1/velero-v1.11.1-darwin-amd64.tar.gz \n  2. tar -xvf velero-v1.11.1-darwin-amd64.tar.gz -C velero-client")
}

output "istio-ingress" {
  value = indent(2, "Istio does not support the installation of istio-helmchart in a namespace other than istio-system. We have provided a namespace feature in case Istio-helmchart maintainers fix this issue.")
}
