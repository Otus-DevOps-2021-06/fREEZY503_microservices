variable "cloud_id" {
  description = "Cloud"
}
variable "folder_id" {
  description = "Folder"
}
variable "zone" {
  description = "Zone"
  # Значение по умолчанию
  default = "ru-central1-a"
}
variable "public_key_path" {
  # Описание переменной
  description = "Path to the public key used for ssh access"
}
variable "subnet_id" {
  description = "Subnet"
}
variable "service_account_key_file" {
  description = "key .json"
}
variable "private_ssh_path" {
  description = "Path to the private ssh key to connect via provision"
}
variable "reddit_disk_image" {
  description = "Disk image for reddit app"
}
variable "count_reddit_app" {
  description = "Number of virtual machines"
}