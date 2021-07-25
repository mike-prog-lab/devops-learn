module "ansible-remote-1" {
  source = "../../../modules/services/ansible-droplet"
  
  droplet_name = "ansible-remote-1"
  ansible_type = "remote"
  setup_scripts_path  = var.ansible_setup_scripts_path
  droplet_region_slug = data.digitalocean_regions.available.regions[0].slug
  ssh_keys            = [var.ssh_pub_key]
}

module "ansible-remote-2" {
  source = "../../../modules/services/ansible-droplet"
  
  droplet_name = "ansible-remote-2"
  ansible_type = "remote"
  setup_scripts_path  = var.ansible_setup_scripts_path
  droplet_region_slug = data.digitalocean_regions.available.regions[0].slug
  ssh_keys            = [var.ssh_pub_key]
}
