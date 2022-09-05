# Creates a Google Service Account.
resource "google_service_account" "storage" {
  account_id   = "svc-webserver-storage"
  display_name = "Webserver Storage SA"
}

# Assign role to service account.
resource "google_project_iam_member" "storage" {
  project = var.project_id
  role    = "roles/storage.admin"
  member  = "serviceAccount:${google_service_account.storage.email}"
}