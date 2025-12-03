resource "kubernetes_deployment" "mariadb"
{
    metadata
    {
        name = "mariadb"
        labels = {
            app = "mariadb"
        }
    }

    spec
    {
        selector
        {
            match_labels = 
            {
                app = "mariadb"
            }
        }
        template
        {
            metadata
            {
                labels = 
                {
                    app = "mariadb"
                }
            }
            spec
            {
                container
                {
                    volume_mount
                    {
                        name = "mariadb_alm"
                        mount_path = "/bitnami/mariadb"
                    }
                    name = "mariadb"
                    image = "bitname/mariadb:latest"
                    port
                    {
                        container_port = 3306
                    }
                    env
                    {
                        name = "ALLOW_EMPTY_PASSWORD"
                        value = var.allow_empty_pass
                    }
                    env
                    {
                        name = "MARIADB_USER"
                        value = var.mariadb_user
                    }
                    env
                    {
                        name = "MARIADB_DATABASE"
                        value = var.mariadb_database
                    }
                }
                volume
                {
                    name = "mariadb_alm"
                    persistent_volume_claim
                    {
                        claim_name = "mariadb-pvc"
                    }
                }
            }
        }
    }
}



resource "kubernetes_service" "service_mariadb" 
{
    metadata
    {
        name = "service_mariadb"
        labels
        {
            app = "mariadb"
        }
    }

    spec
    {
        selector = 
        {
            app = "mariadb"
        }
        type = "ClusterIP"
        port 
        {
            name = "mysql"
            port = 3306
            target_port = 3306
            protocol = "TCP"
        }
    }
}