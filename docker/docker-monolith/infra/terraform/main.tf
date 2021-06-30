provider "yandex" {
  # version = "0.35"
  # token = ""
  service_account_key_file = var.service_account_key_file
  cloud_id                 = var.cloud_id
  folder_id                = var.folder_id
}

module "vpc" {
  source      = "./modules/vpc"
}

module "reddit" {
  source             = "./modules/reddit"
  public_key_path    = var.public_key_path
  reddit_disk_image  = var.reddit_disk_image
  subnet_id          = module.vpc.subnet_id
  count_reddit_app   = var.count_reddit_app
}
