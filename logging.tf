#Fluentbit installtion

resource "helm_release" "fluent_bit" {
    name = "fluent_bit"
    repository = "https://fluent.github.io/helm-charts"
    chart = "fluent-bit"
    namespace = "logging"
    create_namespace = true
}

#Elasticsearch installation

resource "helm_release" "elasticsearch" {
  name       = "elasticsearch"
  repository = "https://helm.elastic.co"
  chart      = "elasticsearch"
  namespace  = "logging"
  create_namespace = true

  set {
    name  = "replicas"
    value = "1"  # Number of Elasticsearch nodes (increase for high availability)
  }

  set {
    name  = "minimumMasterNodes"
    value = "1"  # Minimum number of master nodes required to avoid split-brain issues
  }
}

#Kibana installation

