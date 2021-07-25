variable "do_token" {
  description = "API token for DigitalOcean."
}

provider "digitalocean" {
  token = var.do_token
}
