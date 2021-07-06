provider "yandex" {
  # version = "0.35"
  # token = ""
  service_account_key_file = var.service_account_key_file
  cloud_id                 = var.cloud_id
  folder_id                = var.folder_id
}

module "cluster" {
  source                      = "./modules/cluster"
  service_account_id          = var.service_account_id
  subnet_id                   = var.subnet_id
  zone                        = var.zone
  network_id                  = var.network_id
}

module "node" {
  source             = "./modules/node"
  subnet_id          = var.subnet_id
  zone               = var.zone
  public_key_path    = var.public_key_path
  count_node         = var.count_node
  cluster_id         = module.cluster.cluster_id
}
