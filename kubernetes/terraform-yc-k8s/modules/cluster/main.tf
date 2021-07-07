resource "yandex_kubernetes_cluster" "cluster" {
  name        = "test-cluster"
  network_id  = var.network_id
  ### Включить сетевые политики
  network_policy_provider = "CALICO"

  master {
    version = "1.19"
    zonal {
      zone      = var.zone
      subnet_id = var.subnet_id
    }

    public_ip = true

    maintenance_policy {
      auto_upgrade = true

    }
  }

  service_account_id      = var.service_account_id
  node_service_account_id = var.service_account_id

  release_channel = "RAPID"
}
