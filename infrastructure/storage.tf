resource "random_id" "app" {
  byte_length = 8
}

resource "random_id" "artifact" {
  byte_length = 3
}

resource "google_storage_bucket" "app" {
  name          = "${var.app_name}-${random_id.app.hex}"
  location      = "EU"
  force_destroy = true
  versioning {
    enabled = true
  }
}

resource "google_storage_bucket_object" "nodejs-app" {
  name   = "hello-world-js-${random_id.artifact.hex}.zip"
  source = "hello-world-js.zip"
  bucket = google_storage_bucket.app.name
}

data "archive_file" "app" {
  type             = "zip"
  source_dir       = "../hello-world-js"
  output_file_mode = "0666"
  output_path      = "hello-world-js.zip"
}

resource "google_storage_bucket_iam_member" "app" {
  bucket = google_storage_bucket.app.name
  role   = "roles/storage.objectViewer"
  member = "serviceAccount:${data.google_project.project_number.number}@cloudbuild.gserviceaccount.com"
}