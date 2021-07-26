job "simple-nginx" {
  datacenters = ["fra1"]

  group "web" {
    network {
      mode = "bridge"
    }

    service {
      name = "web-service"
      port = "80"

      connect {
        sidecar_service {}
      }

      check {
        expose   = true
        name     = "web-service-health"
        type     = "http"
        path     = "/health"
        interval = "10s"
        timeout  = "3s"
      }
    }

    task "simple-nginx" {
      driver = "docker"

      config {
        image = "ghcr.io/mike-prog-lab/simple-nginx:latest"
      }

      resources {
        cpu    = 300
        memory = 512
      }
    }
  }
}
