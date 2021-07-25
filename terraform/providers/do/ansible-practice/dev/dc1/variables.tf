variable "ansible_setup_scripts_path" {
  description = "Path to ansible setup scripts."
  type        = string
  default     = "../../../modules/services/ansible-droplet/scripts/setup"
}

variable "ssh_pub_key" {
  description = "SSH key to athenticate ansible droplets."
  type        = string
}
