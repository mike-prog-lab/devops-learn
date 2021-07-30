job "django-app" {
  datacenters = ["fra1"]

  group "frontend" {
    count = 2

    network {
      mode = "bridge"

      port "ingress" {
        static = 80
        to     = 8000
      }
    }

    service {
      name = "nomadrepofe"
      port = "8000"

      connect {
        sidecar_service {
          proxy {
            upstreams {
              destination_name = "nomadrepodb"
              local_bind_port  = 5432
            }
          }
        }
      }
    }

    task "frontend" {
      driver = "docker"

      config {
        image = "schmichael/nomadrepo:0.5"
      }

      resources {
        cpu    = 300
        memory = 500
      }
    }
  }

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
        # TODO: use Vault instead!
        POSTGRES_PASSWORD = "password"
      }

      resources {
        cpu    = 300
        memory = 300
      }
    }
  }
}
