data "digitalocean_regions" "available" {
  filter {
    key    = "available"
    values = ["true"]
  }
  filter {
    key    = "slug"
    match_by = "substring"
    values = ["fra"]
  }
}