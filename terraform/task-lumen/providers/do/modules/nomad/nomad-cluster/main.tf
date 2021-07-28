resource "digitalocean_droplet" "nomad-server-droplet" {
  count    = var.nomad_server_count
  image    = var.droplet_image
  name     = "nomad-server-${count.index}"
  region   = var.droplet_region_slug
  size     = var.server_size
  ssh_keys = var.ssh_keys

  tags = ["nomad-server"]

  provisioner "remote-exec" {
    when       = destroy
    on_failure = continue
    inline = [
      "consul leave -token=$(cat /etc/consul/config.json | jq -rc '.acl.tokens.agent')",
    ]

    connection {
      type = "ssh"
      host = self.ipv4_address
    }
  }
}

resource "digitalocean_droplet" "nomad-client-droplet" {
  count    = var.nomad_client_count
  image    = var.droplet_image
  name     = "nomad-client-${count.index}"
  region   = var.droplet_region_slug
  size     = var.client_size
  ssh_keys = var.ssh_keys

  tags = ["nomad-client"]

  provisioner "remote-exec" {
    when       = destroy
    on_failure = continue
    inline = [
      "consul leave -token=$(cat /etc/consul/config.json | jq -rc '.acl.tokens.agent')",
    ]

    connection {
      type = "ssh"
      host = self.ipv4_address
    }
  }
}
