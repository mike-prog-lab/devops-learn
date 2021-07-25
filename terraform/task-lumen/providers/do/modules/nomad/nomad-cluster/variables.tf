# Count of nodes for Nomad cluster
variable "nomad_server_count" {
  default = 1
  type    = number
}

variable "nomad_client_count" {
  default = 2
  type    = number
}

variable "setup_scripts_path" {
  description = "SSH public key for droplets access."
  type        = string
}

# Node configuration
variable "droplet_region_slug" {
  description = "Provide a region slug where the droplet will be deployed."
  type        = string
}

variable "droplet_image" {
  description = "Image for all cluster nodes."
  default     = "ubuntu-18-04-x64"
  type        = string
}

variable "server_size" {
  description = "The node size for Nomad server nodes."
  default     = "s-1vcpu-1gb"
  type        = string
}

variable "client_size" {
  description = "The node size for Nomad client nodes."
  default     = "s-1vcpu-1gb"
  type        = string
}

variable "ssh_keys" {
  description = "Provide an array of SSH keys for droplet login."
  type        = list(string)
}
