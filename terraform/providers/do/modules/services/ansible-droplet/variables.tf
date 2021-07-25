variable "droplet_name" {
  description = "Provide a name for the Ansible master droplet."
  type        = string
}

variable "droplet_region_slug" {
  description = "Provide a region slug where the droplet will be deployed."
  type        = string
}

variable "ansible_type" {
  description = "Provide a type for the Ansible droplet. Available types are 'master' and 'remote'."
  type        = string
}

variable "setup_scripts_path" {
  description = "Provide a path to ansible setup scripts."
  type        = string
}

variable "ssh_keys" {
  description = "Provide an array of SSH keys."
  type        = list
  default     = []
}