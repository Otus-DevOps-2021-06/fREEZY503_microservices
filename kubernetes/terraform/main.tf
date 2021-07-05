provider "yandex" {
  # version = "0.35"
  # token = ""
  service_account_key_file = var.service_account_key_file
  cloud_id                 = var.cloud_id
  folder_id                = var.folder_id
}

module "node" {
  source             = "./modules/node"
  public_key_path    = var.public_key_path
  image              = var.image
  subnet_id          = var.subnet_id
  count_node         = var.count_node
}
