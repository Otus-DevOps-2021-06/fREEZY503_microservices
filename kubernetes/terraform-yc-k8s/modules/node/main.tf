resource "yandex_kubernetes_node_group" "node" {
  cluster_id  = var.cluster_id
  name        = "node-group"
  version     = "1.19"

  instance_template {
    platform_id = "standard-v2"
    metadata = {
      ssh-keys = "ubuntu:${file(var.public_key_path)}"
    }

    network_interface {
      nat                = true
      subnet_ids         = ["${var.subnet_id}"]
    }

    resources {
      memory = 8
      cores  = 4
    }

    boot_disk {
      type = "network-ssd"
      size = 64
    }

    scheduling_policy {
      preemptible = true
    }
  }

  scale_policy {
    fixed_scale {
      size = var.count_node
    }
  }

  allocation_policy {
    location {
      zone = var.zone
    }
  }

  maintenance_policy {
    auto_upgrade = true
    auto_repair  = true
  }
}