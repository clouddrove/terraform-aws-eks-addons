# ------------------------------------------------------------------------------
# Variables
# ------------------------------------------------------------------------------
variable "label_order" {
  type        = list(string)
  default     = ["name", "environment"]
  description = "Label order, e.g. `name`,`environment`."
}
