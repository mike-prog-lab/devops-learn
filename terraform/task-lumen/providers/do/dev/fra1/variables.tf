# Base DigitalOcean configuration.
variable "do_token" {
  description = "DigitalOcean API token."
  type        = string
}

variable "ssh_pub_key" {
  description = "SSH public key for droplets access."
  type        = string
}

# Vault cluster configuration.
variable "vault_instance_count" {
  default = 1
  type    = number
}

variable "vault_snapshot_id" {
  type = string
}

variable "vault_name" {
  default = "vault"
  type    = string
}

variable "vault_region" {
  type = string
}

variable "vault_size" {
  type = string
}

variable "vault_private_networking" {
  default = true
}

variable "ansible_gen_script" {
  description = "Path to ansible gen script."
}

variable "ansible_root_path" {
  description = "Path where to store ansible inventory file."
}

variable "python_env" {
  description = "Path to python environment."
}
