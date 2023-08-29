locals {
  name = "new-relic-agent"

  # https://github.com/newrelic/helm-charts
  default_helm_config = {
    name        = local.name
    chart       = local.name
    repository  = "https://helm-charts.newrelic.com"
    version     = "5.0.26"
    namespace   = "kube-system"
    description = "Groups together the individual charts for the New Relic Kubernetes solution for a more comfortable deployment."
  }

  helm_config = merge(
    local.default_helm_config,
    var.helm_config
  )

  argocd_gitops_config = {
    enable = true
  }
}
