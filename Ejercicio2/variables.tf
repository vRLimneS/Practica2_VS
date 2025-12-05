variable "mariadb_database" {
  type = string
}

variable "mariadb_user" {
  type = string
}

variable "mariadb_password" {
  type = string
  sensitive = true
}

variable "allow_empty_pass" {
    type = string
}

variable "docker_username" {
  type = string
}