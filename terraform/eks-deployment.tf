provider "kubernetes" {
  host                   = data.aws_eks_cluster.cluster.endpoint
  token                  = data.aws_eks_cluster_auth.cluster.token
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.cluster.certificate_authority.0.data)
}


resource "kubernetes_namespace" "ml_predicting_housing_prices" {
  metadata {
    name = "ml-predicting-housing-prices"
  }
}
resource "kubernetes_deployment" "ml_predicting_housing_prices" {
  metadata {
    name      = "ml-predicting-housing-prices"
    namespace = kubernetes_namespace.ml_predicting_housing_prices.metadata.0.name
  }
  spec {
    replicas = 1
    selector {
      match_labels = {
        app = "ml-predicting-housing-prices"
      }
    }
    template {
      metadata {
        labels = {
          app = "ml-predicting-housing-prices"
        }
      }
      spec {
        container {
          image = var.docker_image
          name  = "ml-predicting-housing-prices"
          port {
            container_port = 80
          }
        }
      }
    }
  }
}
resource "kubernetes_service" "ml_predicting_housing_prices" {
  metadata {
    name      = "ml-predicting-housing-prices"
    namespace = kubernetes_namespace.ml_predicting_housing_prices.metadata.0.name
  }
  spec {
    selector = {
      app = kubernetes_deployment.ml_predicting_housing_prices.spec.0.template.0.metadata.0.labels.app
    }
    type = "LoadBalancer"
    port {
      port        = 80
      target_port = 80
    }
  }
}