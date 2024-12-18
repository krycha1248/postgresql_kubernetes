resource "helm_release" "postgresql" {
  name       = "postgresql"
  repository = "https://charts.bitnami.com/bitnami"
  chart      = "postgresql"
  namespace  = "default"
  version    = "12.1.9"

  set {
    name  = "auth.username"
    value = var.postgresql_user
  }

  set {
    name  = "auth.password"
    value = var.postgresql_password
  }

  set {
    name  = "auth.database"
    value = var.postgresql_user
  }

  set {
    name  = "auth.postgresPassword"
    value = "test"
  }

  set {
    name  = "passwordUpdateJob.enabled"
    value = "true"
  }

  depends_on = [ovh_cloud_project_kube_nodepool.node_pool_d2_4]
}

resource "kubernetes_service" "postgresql" {
  metadata {
    name = "postgresql-service"
    labels = {
      app = "postgresql"
    }
  }

  spec {
    selector = {
      "app.kubernetes.io/name" = "postgresql"
    }

    port {
      port        = 5432
      target_port = 5432
    }

    type = "LoadBalancer"
  }
}

data "kubernetes_service" "postgresql_service" {
  metadata {
    name      = kubernetes_service.postgresql.metadata[0].name
    namespace = "default"
  }
}
