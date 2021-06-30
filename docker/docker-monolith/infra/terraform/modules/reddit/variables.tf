variable zone {
  description = "Zone"
  # Значение по умолчанию
  default = "ru-central1-a"
}
variable public_key_path {
  # Описание переменной
  description = "Path to the public key used for ssh access"
}
variable subnet_id {
  description = "Subnet"
}
variable reddit_disk_image {
description = "Disk image for reddit app"
}
variable "count_reddit_app" {
  description = "Number of virtual machines"
}