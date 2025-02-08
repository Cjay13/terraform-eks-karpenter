resource "helm_release" "kube_prometheus_stack" {
  name       = "kube-prometheus-stack"
  namespace  = "monitoring"
  chart      = "prometheus-community/kube-prometheus-stack"
  version    = "45.0.0"  # Ensure to use the appropriate version

  values = [
    <<-EOF
    grafana:
      service:
        type: LoadBalancer
        port: 80
    EOF
  ]
}
