agent_prefix "nomad-client" {
  policy = "read"
}

node_prefix "nomad-client" {
  policy = "read"
}

service_prefix "nomad-clients" {
  policy = "write"
}

# uncomment if using Consul KV with Consul Template
# key_prefix "" {
#   policy = read
# }
