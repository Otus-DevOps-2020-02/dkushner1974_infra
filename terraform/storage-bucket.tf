provider "google" {
  version = "~> 2.15"
  project = var.project
  region  = var.region
  zone    = var.zone

}

module "storage-bucket" {
  source  = "SweetOps/storage-bucket/google"
  version = "~> 0.3.0"

  location = var.region
  # »м€ помен€йте на другое
  name = "sb-otus-devops-dk"

}

output storage-bucket_url {
  value = module.storage-bucket.url
}
