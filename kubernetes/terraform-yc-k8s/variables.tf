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
variable "image" {
  description = "Disk image for nodes"
}
variable "count_node" {
  description = "Number of virtual machines"
}
variable network_id {
  description = "Network"
}
variable service_account_id{
  description = "Path to the service acc key used for"
}