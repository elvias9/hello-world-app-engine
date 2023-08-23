### Add Roles to Cloud Build Default Service Account                                   #

data "google_project" "project_number" {
}


resource "google_project_iam_member" "cb_iam_member" {
  for_each = toset(var.project_roles)
  project  = var.project_id
  role     = each.key
  member   = "serviceAccount:${data.google_project.project_number.number}@cloudbuild.gserviceaccount.com"
}