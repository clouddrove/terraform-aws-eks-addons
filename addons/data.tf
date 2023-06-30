data "aws_partition" "current" {}
data "aws_caller_identity" "current" {}
data "aws_region" "current" {}

resource "time_sleep" "dataplane" {
  create_duration = "10s"

  triggers = {
    data_plane_wait_arn = var.data_plane_wait_arn # this waits for the data plane to be ready
    eks_cluster_id      = var.eks_cluster_id      # this ties it to downstream resources
  }
  depends_on = [ 
    var.eks_cluster_id
   ]
}

data "aws_eks_cluster" "eks_cluster" {
  # this makes downstream resources wait for data plane to be ready
  name = var.eks_cluster_name
  depends_on = [ 
    var.eks_cluster_id
   ]
}
