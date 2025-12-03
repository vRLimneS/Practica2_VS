resource "kubernetes_deployment" "matomo"
{
    metadata
    {
        name = "matomo"
        labels =
        {
            app = "matomo"
        }
    }

    spec
    {
        replicas = 1

        selector
        {
            match_labels =
            {
                app = "matomo"
            }
        }

        strategy
        {
            type = "Recreate"
        }

        template
        {
            metadata
            {
                labels =
                {
                    app = "matomo"
                }
            }

            spec
            {
                container
                {
                    name = "matomo"
                    image = "${var.docker_registry}/${var.docker_username}/matomo:latest"

                    port
                    {
                        container_port = 80
                        name = "http"
                    }

                    env
                    {
                        name = "MATOMO_DATABASE_HOST"
                        value = "service-mariadb"
                    }

                    env
                    {
                        name = "MATOMO_DATABASE_ADAPTER"
                        value = "mysql"
                    }

                    env
                    {
                        name = "MATOMO_DATABASE_TABLES_PREFIX"
                        value = "matomo_"
                    }

                    env
                    {
                        name = "MATOMO_DATABASE_USERNAME"
                        value = var.mariadb_user
                    }

                    env
                    {
                        name = "MATOMO_DATABASE_PASSWORD"
                        value = var.mariadb_password
                    }

                    env
                    {
                        name = "MATOMO_DATABASE_DBNAME"
                        value = var.mariadb_database
                    }

                    volume_mount
                    {
                        name = "matomo-data"
                        mount_path = "/var/www/html"
                    }

                    resources
                    {
                        requests =
                        {
                            cpu = "100m"
                            memory = "256Mi"
                        }
                        limits =
                        {
                            cpu = "500m"
                            memory = "512Mi"
                        }
                    }
                }

                volume
                {
                    name = "matomo-data"
                    persistent_volume_claim
                    {
                        claim_name = "matomo-pvc"
                    }
                }
            }
        }
    }
}

# Service de Matomo (NodePort)
resource "kubernetes_service" "matomo_service"
{
    metadata
    {
        name = "matomo-service"
        labels =
        {
            app = "matomo"
        }
    }

    spec
    {
        type = "NodePort"

        selector =
        {
            app = "matomo"
        }

        port
        {
            name = "http"
            port = 80
            target_port = 80
            node_port = 30081
            protocol = "TCP"
        }
    }
}
