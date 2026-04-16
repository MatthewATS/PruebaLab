# Arquitectura Web, API y BD con Terraform

Despliegue automatizado de una arquitectura de 3 capas utilizando Docker y Terraform. 
Incluye empaquetado de imágenes personalizadas para el Frontend (Nginx) y el Backend (Java 17).

## Requisitos Previos
- Docker Desktop / Engine ejecutándose.
- Terraform instalado.

## Puertos y Entornos
| Servicio | Default (Local) | Dev / QA |
| :--- | :--- | :--- |
| **WEB01** | `:4001` | `:5001` |
| **API** | `:4002` | `:5002` |
| **BD** | `:4003` | `:5003` |

## Guía de Despliegue

1. **Inicializar Terraform** (Descarga proveedores):
   ```bash
   terraform init