# PersistentVolumeClaim para WordPress
resource "kubernetes_persistent_volume_claim" "matomo_pvc" {
  metadata {
    name = "matomo-pvc"
  }
  spec {
    access_modes = ["ReadWriteOnce"]
    resources {
      requests = {
        storage = "1Gi"
      }
    }
    storage_class_name = "standard"
  }
}

# PersistentVolumeClaim para MariaDB
resource "kubernetes_persistent_volume_claim" "mariadb_pvc" {
  metadata {
    name = "mariadb-pvc"
  }
  spec {
    access_modes = ["ReadWriteOnce"]
    resources {
      requests = {
        storage = "1Gi"
      }
    }
    storage_class_name = "standard"
  }
}