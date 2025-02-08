#Fluentbit installtion

resource "helm_release" "fluentbit" {
    name = "fluentbit"
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
    value = "Null"
  }

  set {
    name = "persistence.enabled"
    value = "false"
  }

  set {
    name = "esConfig.discovery.type"
    value = "single-node"
  }
}

#Kibana installation

resource "helm_release" "kibana" {
  name = "kibana"
  repository = "https://helm.elastic.co"
  chart = "kibana"
  namespace = "logging"
  create_namespace = true

  set {
    name  = "service.type"
    value = "ClusterIP"
  }

  set {
    name  = "ingress.enabled"
    value = "true"
  }

  set {
    name  = "ingress.className"
    value = "nginx"
  }

  set {
    name  = "ingress.hosts[0].host"
    value = "a99ec9b4fd7d343d5affcd04c0bcf83f-1046850647.us-east-1.elb.amazonaws.com"
  }

  set {
    name  = "ingress.hosts[0].paths[0].path"
    value = "/kibana"
  }

  set {
    name  = "ingress.hosts[0].paths[0].pathType"
    value = "ImplementationSpecific"
  }
}

