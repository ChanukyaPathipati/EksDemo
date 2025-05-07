provider "helm" {
  kubernetes {
    config_path = "~/.kube/config" # Make sure the path to kubeconfig is correct
  }
}



resource "helm_release" "external_nginx" {
  name       = "external"
  repository = "https://kubernetes.github.io/ingress-nginx"
  chart      = "ingress-nginx"
  namespace  = var.kubernetes_namespace
  version    = "4.10.1"

  create_namespace = true

  values = [
    file("${path.module}/my-webapp/nginx-nlb-values.yaml"),
    <<EOF
controller:
  admissionWebhooks:
    enabled: false
EOF
  ]
}



resource "helm_release" "webapp" {
  name       = "webapp"
  chart      = "./my-webapp"
  namespace  = var.kubernetes_namespace
  create_namespace = true 
  
  set {
    name  = "ingress.className"
    value = "external-nginx"
  }
}
