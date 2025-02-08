resource "helm_release" "kube_prometheus_stack" {
  name       = "kubeprometheusstack"
  repository = "prometheus-community https://prometheus-community.github.io/helm-charts"
  namespace  = "monitoring"
  chart      = "kube-prometheus-stack"


  values = [
    <<-EOF
    grafana:
      service:
        type: LoadBalancer
        port: 80
    EOF
  ]
}
