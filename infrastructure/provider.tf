terraform {
  required_version = ">= 0.13"
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 3.84"
    }
     google-beta = {
      source  = "hashicorp/google-beta"
      version = "~> 3.84"
    }
  }
}


provider "google" {
  project = var.project_id
  region  = var.project_region
}
provider "google-beta" {
  project = var.project_id
  region  = var.project_region
}