provider "google" {
  version = "~> 2.15"
  project = var.project
  region  = var.region
}


module "db" {
  source          = "../modules/db"
  public_key_path = var.public_key_path
  db_disk_image   = var.db_disk_image
  private_key_path = var.private_key_path
}
module "app" {
  source          = "../modules/app"
  public_key_path = var.public_key_path
  app_disk_image  = var.app_disk_image
  db_ip_address = module.db.db_external_ip
   private_key_path = var.private_key_path
}

module "vpc" {
  source        = "../modules/vpc"
  source_ranges = ["0.0.0.0/0"]
}
