terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0.1"
    }
  }
}

provider "docker" {}

# Red interna (Recuadro rojo punteado "DOCKER")
resource "docker_network" "app_network" {
  name = "app_network_${var.environment}"
}

# --- IMÁGENES ---
resource "docker_image" "nginx_custom" {
  name = "mi-web-frontend:latest"
  build {
    context = "${path.module}/web"
  }
}

resource "docker_image" "java_custom" {
  name = "mi-api-backend:latest"
  build {
    context = "${path.module}/api"
  }
}

resource "docker_image" "postgres" {
  name         = "postgres:14-alpine"
  keep_locally = true
}

# --- CONTENEDORES ---
resource "docker_container" "web" {
  name  = local.env_vars.web_name
  image = docker_image.nginx_custom.image_id

  ports {
    internal = 80
    external = local.env_vars.web_port
  }
  
  networks_advanced {
    name = docker_network.app_network.name
  }
}

resource "docker_container" "api" {
  name  = local.env_vars.api_name
  image = docker_image.java_custom.image_id

  ports {
    internal = 8080 
    external = local.env_vars.api_port
  }

  networks_advanced {
    name = docker_network.app_network.name
  }
}

resource "docker_container" "bd" {
  name  = local.env_vars.bd_name
  image = docker_image.postgres.image_id

  env = [
    "POSTGRES_USER=admin",
    "POSTGRES_PASSWORD=secret",
    "POSTGRES_DB=app_db"
  ]

  ports {
    internal = 5432
    external = local.env_vars.bd_port
  }
}