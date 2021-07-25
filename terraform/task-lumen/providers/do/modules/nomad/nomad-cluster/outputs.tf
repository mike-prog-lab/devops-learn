output "server-nodes" {
  value = tolist(digitalocean_droplet.nomad-server-droplet)
}

output "client-nodes" {
  value = tolist(digitalocean_droplet.nomad-client-droplet)
}
