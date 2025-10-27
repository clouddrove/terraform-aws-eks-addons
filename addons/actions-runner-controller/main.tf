module "helm_addon" {
  source = "../helm"

  manage_via_gitops = var.manage_via_gitops
  helm_config       = local.helm_config
  addon_context     = var.addon_context
  depends_on        = [kubernetes_secret.github_app_secret]
}

resource "kubernetes_secret" "github_app_secret" {
  count = try(var.actions_runner_controller_extra_configs.github_pat_token, "") != "" ? 1 : 0
  metadata {
    name      = "controller-manager"
    namespace = try(var.actions_runner_controller_extra_configs.namespace, local.default_helm_config.namespace)
  }
  data = {
    github_token = try(var.actions_runner_controller_extra_configs.github_pat_token, "")
  }
  depends_on = [kubernetes_namespace.arc_namespace]
}

resource "kubernetes_namespace" "arc_namespace" {
  count = try(var.actions_runner_controller_extra_configs.create_namespace, false) ? 1 : 0
  metadata {
    name = try(var.actions_runner_controller_extra_configs.namespace, local.default_helm_config.namespace)
  }
}

resource "kubectl_manifest" "runner_deployment" {
  count = try(var.actions_runner_controller_extra_configs.runner_deployment_yaml, "") != "" ? 1 : 0
  yaml_body = (
    try(var.actions_runner_controller_extra_configs.runner_deployment_yaml, "") != ""
  ) ? file(var.actions_runner_controller_extra_configs.runner_deployment_yaml) : null
  depends_on = [module.helm_addon]
}