job "django-app" {
  group "db" {
    network {
      mode = "bridge"
    }

    service {
      name = "nomadrepodb"
      port = "5432"

      connect {
        sidecar_service {}
      }
    }

    task "postgres" {
      driver = "docker"
      config {
        image = "postgres:13"
      }

      env {
        POSTGRES_PASSWORD = "<TODO: Use Vault!>"
      }

      resources {
        cpu    = 300
        memory = 300
      }
    }
  }
}
