resource "yandex_compute_instance" "reddit" {
  count = var.count_reddit_app
  name  = "reddit-app-${count.index}"
  zone  = var.zone

  labels = {
      tags = "reddit-app-${count.index}"
  }
  resources {
    cores  = 2
    memory = 2
    core_fraction = 5
  }

  boot_disk {
    initialize_params {
      image_id = var.reddit_disk_image
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
