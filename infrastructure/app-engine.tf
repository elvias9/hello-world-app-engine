resource "google_app_engine_application" "app" {
  project     = var.project_id
  location_id = var.project_region
}

resource "google_app_engine_flexible_app_version" "myapp_v1" {
  version_id = "v1"
  project    = var.project_id
  service    = var.service
  runtime    = "nodejs"

  entrypoint {
    shell = "node ./app.js"
  }

  deployment {
    zip {
      source_url = "https://storage.googleapis.com/${google_storage_bucket.app.name}/${google_storage_bucket_object.nodejs-app.name}"
    }
  }

  liveness_check {
    path = "/liveness_check"
  }

  readiness_check {
    path = "/readiness_check"
    app_start_timeout = "800s"
  }

  
  automatic_scaling {
    cool_down_period = "120s"
    cpu_utilization {
      target_utilization = 0.5
    }
  }

  network  {
    name             = google_compute_network.vpc.name
    subnetwork       = google_compute_subnetwork.private.name
    forwarded_ports  = null
    instance_tag     = "app-engine-vm"
    session_affinity = true
  }
  #remove these after testing 
  noop_on_destroy           = false
  delete_service_on_destroy = true

depends_on = [ google_storage_bucket.app, google_storage_bucket_object.nodejs-app, google_compute_network.vpc, google_compute_subnetwork.private ]
}