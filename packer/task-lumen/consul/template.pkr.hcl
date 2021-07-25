packer {
  required_plugins {
    digitalocean = {
      version = ">= 1.0.0"
      source  = "github.com/hashicorp/digitalocean"
    }
  }
}

variable "do_token" {
  type = string
}

variable "base_system_image" {
  type = string
}

variable "region" {
  type = string
}

variable "size" {
  type = string
}

source "digitalocean" "main" {
  api_token     = var.do_token
  image         = var.base_system_image
  region        = var.region
  size          = var.size
  ssh_username  = "root"
  snapshot_name = "consul"
}

build {
  sources = ["source.digitalocean.main"]

  provisioner "shell" {
    inline = [
      "sleep 30",
      "curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add -",
      "sudo apt-add-repository -y \"deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main\"",
      "sudo apt-get update -y && sudo apt-get install consul jq -y",
      "consul keygen"
    ]
  }
}
