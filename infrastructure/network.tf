resource "google_compute_network" "vpc" {
  name                    = "${var.app_name}-vpc"
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "private" {
  name                     = "${var.app_name}-subnet"
  ip_cidr_range            = var.app_ip_range
  region                   = var.project_region
  network                  = google_compute_network.vpc.id
  private_ip_google_access = true
}