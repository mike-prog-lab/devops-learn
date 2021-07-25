terraform {
  required_providers {
    digitalocean = {
      source = "digitalocean/digitalocean"
      version = "2.10.1"
    }
  }
}

resource "digitalocean_droplet" "ansible-droplet" {
  image  = "ubuntu-18-04-x64"
  name   = var.droplet_name
  region = var.droplet_region_slug
  size   = "s-1vcpu-1gb"
  ssh_keys = var.ssh_keys

  tags = ["ansible-dev", "ansible-${var.ansible_type}"]

  user_data = file("${var.setup_scripts_path}/ansible-setup-${var.ansible_type}.sh")
}