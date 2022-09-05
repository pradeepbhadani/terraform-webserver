locals {
  webpage_path = "webpage/index.html"
}

resource "google_storage_bucket" "webserver_config" {
  name     = "${var.project_id}-webserver-configs"
  location = var.region
}

resource "google_storage_bucket_object" "webpage" {
  name   = local.webpage_path
  source = "${path.module}/files/index.html"
  bucket = google_storage_bucket.webserver_config.name
}