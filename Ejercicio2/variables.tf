variable "mariadb_database" {
  type = string
  description = "Database name"
}

variable "mariadb_user" {
  type = string
  description = "Database user"
}

variable "mariadb_password" {
  type = string
  description = "Database password"
  sensitive = true
}

variable "allow_empty_pass" {
    type = string
    description = "Pass empty"
}

variable "docker_registry" {
  type = string
  description = "Docker registry (e.g., docker.io)"
  default = "docker.io"
}

variable "docker_username" {
  type = string
  description = "Docker Hub username"
}

variable "cluster_name" {
  type = string
  description = "Kind cluster name"
  default = "kubernetes-cluster"
}

variable "cluster_context" {
  type = string
  description = "Kubernetes context name"
  default = "kind-kubernetes-cluster"
}