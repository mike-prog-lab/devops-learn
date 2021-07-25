resource "digitalocean_droplet" "nomad-server-droplet" {
  count    = var.nomad_server_count
  image    = var.droplet_image
  name     = "nomad-server-${count.index}"
  region   = var.droplet_region_slug
  size     = var.server_size
  ssh_keys = var.ssh_keys

  tags = ["nomad-server"]
}

resource "digitalocean_droplet" "nomad-client-droplet" {
  count    = var.nomad_client_count
  image    = var.droplet_image
  name     = "nomad-client-${count.index}"
  region   = var.droplet_region_slug
  size     = var.client_size
  ssh_keys = var.ssh_keys

  tags = ["nomad-client"]
}
