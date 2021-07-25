terraform {
  required_providers {
    digitalocean = {
      source = "digitalocean/digitalocean"
      version = "~> 2.0"
    }
  }

  backend "s3" {
    endpoint  = "https://minio.core.infra.eml.ua"
    key       = "terraform.tfstate"
    region    = "main"
    force_path_style = true
    skip_requesting_account_id  = true
    skip_credentials_validation = true
    skip_get_ec2_platforms  = true
    skip_metadata_api_check = true
    skip_region_validation  = true
  }
}