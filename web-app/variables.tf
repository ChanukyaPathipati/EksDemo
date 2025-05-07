# variable "kubernetes_namespace" {}

variable "kubernetes_namespace" {
  description = "Kubernetes namespace to deploy resources"
  type        = string
  default     = "web-app"
}


