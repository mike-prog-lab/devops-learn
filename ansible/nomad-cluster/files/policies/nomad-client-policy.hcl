agent_prefix "nomad-client" {
  policy = "write"
}

node_prefix "nomad-client" {
  policy = "write"
}

node_prefix "nomad-server" {
  policy = "read"
}

service "nomad-servers" {
  policy = "read"
}

service "nomad-clients" {
  policy = "write"
}

# uncomment if using Consul KV with Consul Template
# key_prefix "" {
#   policy = read
# }
