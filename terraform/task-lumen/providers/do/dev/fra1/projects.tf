resource "digitalocean_project" "tasks-lumen" {
  name        = "Tasks Lumen"
  description = "Tasks Lumen is a test project for DevOps practice."
  purpose     = "CI/CD"
  environment = "Development"

  resources = concat(
    tolist(module.nomad-cluster.server-nodes)[*].urn,
    tolist(module.nomad-cluster.client-nodes)[*].urn
  )

  # resources = tolist(digitalocean_droplet.vault)[*].urn
}
