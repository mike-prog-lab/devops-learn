job "docs" {
  datacenters = ["dc1"]


  group "example" {
    network {
      port "http" {
        static = "5678"
      }
    }

    task "server" {
      driver = "exec"

      config {
        command = "/bin/http-echo"

        args = [
          "-listen",
          ":5678",
          "-text",
          "hello world",
        ]
      }
    }
  }
}
