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

variable "docker_username" {
  type = string
  description = "Docker Hub username"
}