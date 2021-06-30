output "external_ip_addresses_reddit" {
  value = toset([
    for reddit in yandex_compute_instance.reddit : reddit.network_interface.0.nat_ip_address
  ])
}