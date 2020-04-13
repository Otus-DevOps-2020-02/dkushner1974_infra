resource "google_compute_instance" "app" {
  name         = "reddit-app"
  machine_type = "g1-small"
  zone         = var.zone
  #  project = var.project
  tags = ["reddit-app"]
  boot_disk {
    initialize_params { image = var.app_disk_image }
  }
  network_interface {
    network = "default"
    access_config {
      nat_ip = google_compute_address.app_ip.address
    }
  }
  metadata = {
    ssh-keys = "appuser:${file(var.public_key_path)}"
  }

  connection {
    type        = "ssh"
    host        = self.network_interface[0].access_config[0].nat_ip
    user        = "appuser"
    agent       = false
    private_key = file(var.private_key_path)
  }

 #provisioner "local-exec" {
#    command  = "sed -i \"s/changeOnDeploy/${var.db_ip_address}/\" ${path.module}/puma.service"
#  }


 provisioner "file" {
    source      = "${path.module}/puma.service"
    destination = "/tmp/puma.service"
  }


 provisioner "remote-exec" {
    inline = [
      "sed -i \"s/changeOnDeploy/${var.db_ip_address}/\" /tmp/puma.service",
    ]
  }



 provisioner "remote-exec" {
   script = "${path.module}/deploy.sh"
  }





}

resource "google_compute_address" "app_ip" {
  name = "reddit-app-ip"
}

resource "google_compute_firewall" "firewall_puma" {
  name    = "allow-puma-default"
  network = "default"
  allow {
    protocol = "tcp"
    ports    = ["9292"]
  }
  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["reddit-app"]
}
