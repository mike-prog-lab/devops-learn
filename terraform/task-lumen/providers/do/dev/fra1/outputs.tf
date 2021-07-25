output "nomad_server_ipv4_list" {
  description = "The Nomad Server ipv4 addresses"
  value       = module.nomad-cluster.server-nodes[*].ipv4_address
}

output "nomad_client_ipv4_list" {
  description = "The Nomad Client ipv4 addresses"
  value       = module.nomad-cluster.client-nodes[*].ipv4_address
}

output "vault_ipv4_addrs" {
  value = {
    for instance in digitalocean_droplet.vault :
    instance.id => instance.ipv4_address
  }
  description = "The IP addresses of the deployed instances, paired with their IDs."
}
