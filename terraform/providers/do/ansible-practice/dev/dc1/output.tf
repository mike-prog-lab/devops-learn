# Droplet IPv4 addresses.
output "do_droplet_ansible_remote_1_ipv4" {
  value = module.ansible-remote-1.droplet.ipv4_address
}
output "do_droplet_ansible_remote_2_ipv4" {
  value = module.ansible-remote-2.droplet.ipv4_address
}
