variable subnet_id {
  description = "Subnet"
}
variable count_node {
  description = "Count node"
}
variable zone {
  description = "Zone"
  # Значение по умолчанию
  default = "ru-central1-a"
}
variable public_key_path {
  description = "Path to public ssh key"
}
variable cluster_id {
  description = "Cluster ID"
}

