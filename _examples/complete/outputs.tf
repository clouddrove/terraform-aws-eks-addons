# ------------------------------------------------------------------------------
# Outputs
# ------------------------------------------------------------------------------
output "cluster_name" {
  value = module.eks.cluster_name
}

output "region" {
  value = local.region
}

output "update_kubeconfig" {
  value = "aws eks update-kubeconfig --name ${module.eks.cluster_name} --region ${local.region}"
}

output "velero_post_installation" {
  value = <<EOF
Once velero server is up and running you need the client before you can use it
1. wget https://github.com/vmware-tanzu/velero/releases/download/v1.11.1/velero-v1.11.1-darwin-amd64.tar.gz
2. tar -xvf velero-v1.11.1-darwin-amd64.tar.gz -C velero-client  
  EOF  
}