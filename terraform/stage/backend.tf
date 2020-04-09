terraform {
  backend "gcs" {
    bucket  = "sb-otus-devops-dk"
    prefix  = "terraform/stage"
  }
}
