module "nomad-cluster" {
  source = "../../modules/nomad/nomad-cluster"

  nomad_server_count = var.nomad_servers
  nomad_client_count = var.nomad_clients

  droplet_region_slug = "fra1"
  ssh_keys            = [var.ssh_pub_key]

  setup_scripts_path = "../../modules/nomad/nomad-cluster/scripts/"
}

resource "digitalocean_droplet" "vault" {
  count              = var.vault_instance_count
  image              = var.vault_image
  name               = "vault-${count.index}"
  region             = var.vault_region
  size               = var.vault_size
  private_networking = var.vault_private_networking

  tags = [
    "vault",
  ]

  ssh_keys = [
    var.ssh_pub_key,
  ]
}

resource "null_resource" "nomad-cluster" {
  # Changes to any instance of the cluster requires re-provisioning
  triggers = {
    nomad_servers_count = var.nomad_servers
    nomad_clients_count = var.nomad_clients
    nomad_client_ips    = "${join(",", module.nomad-cluster.client-nodes[*].ipv4_address)}"
  }

  provisioner "local-exec" {
    command = "source '${var.python_env}/bin/activate'; python '${var.ansible_gen_script}' --inv-path '${var.ansible_root_path}/inventory.conf' --nomad-servers ${join(" ", tolist(module.nomad-cluster.server-nodes[*].ipv4_address))} --nomad-clients ${join(" ", tolist(module.nomad-cluster.client-nodes[*].ipv4_address))} --vault-instances ${join(" ", digitalocean_droplet.vault[*].ipv4_address)}"
  }

  provisioner "local-exec" {
    command = "sleep 120; set -a; source '${var.ansible_root_path}/.env'; ansible-playbook -i '${var.ansible_root_path}/inventory.conf' '${var.ansible_root_path}/setup-nomad-cluster.yml'"
  }
}
