resource "kubernetes_deployment" "mariadb" {
    metadata {
        name = "mariadb"
        labels = {
            app = "mariadb"
        }
    }

    spec {
        selector {
            match_labels = {
                app = "mariadb"
            }
        }
        template {
            metadata {
                labels = {
                    app = "mariadb"
                }
            }
            spec {
                container {
                    volume_mount {
                        name = "mariadb-alm"
                        mount_path = "/bitnami/mariadb"
                    }
                    name = "mariadb"
                    image = "bitnami/mariadb:latest"
                    port {
                        container_port = 3306
                    }
                    env {
                        name = "ALLOW_EMPTY_PASSWORD"
                        value = "yes"
                    }
                    env {
                        name = "MARIADB_ROOT_PASSWORD"
                        value = var.mariadb_password
                    }
                    env {
                        name = "MARIADB_USER"
                        value = var.mariadb_user
                    }
                    env {
                        name = "MARIADB_PASSWORD"
                        value = var.mariadb_password
                    }
                    env {
                        name = "MARIADB_DATABASE"
                        value = var.mariadb_database
                    }
                }
                volume {
                    name = "mariadb-alm"
                    persistent_volume_claim {
                        claim_name = "mariadb-pvc"
                    }
                }
            }
        }
    }
}

resource "kubernetes_service" "service-mariadb" {
    metadata {
        name = "service-mariadb"
        labels = {
            app = "mariadb"
        }
    }

    spec {
        selector = {
            app = "mariadb"
        }
        type = "ClusterIP"
        port {
            name = "mysql"
            port = 3306
            target_port = 3306
            protocol = "TCP"
        }
    }
}
