# ------------------------------------------------------------------------------
# Variables
# ------------------------------------------------------------------------------

variable "istio_manifests" {
  type = object({
    istio_ingress_manifest_file_path = list(any)
    istio_gateway_manifest_file_path = list(any)
  })
  default = {
    istio_ingress_manifest_file_path = ["./config/istio/ingress.yaml", "./config/istio/ingress-internal.yaml"]
    istio_gateway_manifest_file_path = ["./config/istio/gateway.yaml"]
  }
  description = "Path to yaml manifests to create Ingress and Gateway with specified host"
}

variable "kiali_manifests" {
  type = object({
    kiali_virtualservice_file_path = string
  })
  default = {
    kiali_virtualservice_file_path = "./config/kiali/kiali_vs.yaml"
  }
  description = "Path to VirtualService manifest for kiali-dashboard"
}