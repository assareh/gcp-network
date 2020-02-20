terraform {
  required_version = ">= 0.12"
}

provider "google" {
  credentials = var.gcp_credentials
  project     = var.gcp_project
  region      = var.gcp_region
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

module "network" {
  source  = "terraform-google-modules/network/google"
  version = "2.1.1"

  network_name = "assareh-gke"
  project_id   = "andy-assareh-demo"
  subnets = [
    {
      subnet_name   = "subnet-01"
      subnet_ip     = "10.10.10.0/24"
      subnet_region = "us-west1"
    },
  ]
}

output "network_name" {
  value = module.network.network_name
}

output "subnet_name" {
  value = module.network.subnets_names
}