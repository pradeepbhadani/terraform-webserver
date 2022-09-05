data "google_compute_image" "ubuntu" {
  family  = "ubuntu-2204-lts"
  project = "ubuntu-os-cloud"
}

# Creates a GCP VM Instance. Metadata Startup script install the Nginx webserver.
resource "google_compute_instance" "vm" {
  name         = var.name
  machine_type = var.machine_type
  zone         = var.zone
  tags         = ["http-server"]
  labels       = var.labels

  boot_disk {
    initialize_params {
      image = data.google_compute_image.ubuntu.self_link
    }
  }

  network_interface {
    network = "default"
    access_config {
      // Ephemeral IP
    }
  }

  metadata_startup_script = data.template_file.nginx.rendered
  service_account {
    email  = google_service_account.storage.email
    scopes = ["storage-rw"]
  }
  depends_on = [google_storage_bucket_object.webpage]
}

data "template_file" "nginx" {
  template = file("${path.module}/template/install_nginx.tpl")

  vars = {
    ufw_allow_nginx = "Nginx HTTP"
    bucket_name     = google_storage_bucket.webserver_config.name
    webpage_path    = local.webpage_path
  }
}


