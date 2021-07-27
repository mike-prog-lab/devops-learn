agent_prefix "nomad-server" {
  policy = "read"
}

node_prefix "nomad-server" {
  policy = "write"
}

service_prefix "nomad-servers" {
  policy = "write"
}

acl = "write"
