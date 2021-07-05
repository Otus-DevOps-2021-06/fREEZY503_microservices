output "external_ip_addresses_node" {
  value = toset([
    for node in yandex_compute_instance.node : node.network_interface.0.nat_ip_address
  ])
}