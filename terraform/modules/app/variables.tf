variable public_key_path {
  description = "Path to the public key used to connect to instance"
}

variable zone {
  description = "Zone"
  default     = "europe-west1-b"
}

variable app_disk_image {
  description = "Disk image for reddit app"
  default     = "reddit-app-base"
}

variable private_key_path {
  description = "Path to the private key"
}

variable db_ip_address {
   description = "mongo ip"
}
