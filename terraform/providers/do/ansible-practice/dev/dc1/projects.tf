resource "digitalocean_project" "devops-testing" {
  name = "DevOps testing"
  description = "A project for DevOps"
  purpose = "CI/CD"
  environment = "Development"
  
  resources = [
    module.ansible-remote-1.droplet.urn,
    module.ansible-remote-2.droplet.urn,
  ]
}
