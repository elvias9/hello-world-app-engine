variable "project_id" {
  type    = string
  default = "cr-lab-esicuro-1408230459"
}

variable "project_region" {
  type    = string
  default = "europe-west2"
}

variable "app_name" {
  type    = string
  default = "hello-world"
}

variable "app_ip_range" {
    type = string
    default = "10.10.0.0/24"
}

variable "project_roles" {
  description = "List of IAM roles"
  type        = list(string)
  default = [
    "roles/iam.serviceAccountUser",
    "roles/clouddeploy.releaser",
    "roles/appengine.appAdmin",
    "roles/appengine.deployer",
    "roles/storage.objectViewer",
    "roles/compute.networkUser"
  ]
}

variable "service" {
  description = "(Required; Default: default) Name of the App Engine Service"
  type        = string
  default     = "default"

  validation {
    condition     = length(var.service) > 0 && length(var.service) < 63
    error_message = "The Service name can't be null and the length cannot exceed 63 characters."
  }
}