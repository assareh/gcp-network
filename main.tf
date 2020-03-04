terraform {
  required_version = ">= 0.12"
}

variable "gcp_credentials" {
  description = "GCP credentials needed by google provider"
}

variable "gcp_region" {
  description = "GCP region, e.g. us-east1"
  default     = "us-west1"
}

variable "gcp_project" {
  description = "GCP project name"
}

variable "network_name" {
  default = "tf-gke-k8s"
}

provider "google" {
  credentials = var.gcp_credentials
  project     = var.gcp_project
  region      = var.gcp_region
}

resource "google_compute_network" "default" {
  name                    = var.network_name
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "default" {
  name                     = var.network_name
  ip_cidr_range            = "10.127.0.0/20"
  network                  = google_compute_network.default.self_link
  region                   = var.gcp_region
  private_ip_google_access = true
}

output network {
  value = google_compute_subnetwork.default.network
}

output subnetwork_name {
  value = google_compute_subnetwork.default.name
}
