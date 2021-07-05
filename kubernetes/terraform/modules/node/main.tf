resource "yandex_compute_instance" "node" {
  count = var.count_node
  name  = "node-${count.index}"
  zone  = var.zone

  labels = {
      tags = "node-${count.index}"
  }
  resources {
    cores  = 4
    memory = 4
    core_fraction = 5
  }

  boot_disk {
    initialize_params {
      image_id = var.image
      type     = "network-ssd"
      size     = 40
    }
  }

  network_interface {
    subnet_id = var.subnet_id
    nat = true
  }

  metadata = {
    ssh-keys = "ubuntu:${file(var.public_key_path)}"
  }
}
