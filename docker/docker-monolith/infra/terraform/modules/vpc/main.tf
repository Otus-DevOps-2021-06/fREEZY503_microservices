resource "yandex_vpc_network" "reddit-network" {
  name = "reddit-network"
}

resource "yandex_vpc_subnet" "reddit-subnet" {
  name           = "reddit-subnet"
  zone           = "ru-central1-a"
  network_id     = yandex_vpc_network.reddit-network.id
  v4_cidr_blocks = ["192.168.10.0/24"]
}