variable "environment" {
  description = "Entorno a desplegar (default o dev)"
  type        = string
  default     = "default"
}

locals {
  config = {
    default = {
      web_name = "web-LOCAL-01"
      web_port = 4001
      api_name = "api01"
      api_port = 4002
      bd_name  = "bd"
      bd_port  = 4003
    }
    dev = {
      web_name = "web-DEV-11"
      web_port = 5001
      api_name = "api01"
      api_port = 5002 
      bd_name  = "bd"
      bd_port  = 5003
    }
  }
  env_vars = local.config[var.environment]
}