
variable "eks_cluster_name" {
  type    = string
  default = ""
}

variable "slack_config" {
  type = object({
    slack_webhook_url = string
    slack_channel     = string
  })
}