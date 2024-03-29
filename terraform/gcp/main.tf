provider "google" {
  project     = "three-tier-multicloud"
  region      = "us-central1"
}

provider "google-beta" {
  project     = "three-tier-multicloud"
  region      = "us-central1"
}

provider "kubernetes" {
  host                   = "https://${module.gke.endpoint}"
  token                  = data.google_client_config.default.access_token
  cluster_ca_certificate = base64decode(module.gke.ca_certificate)
}

data "google_client_config" "default" {}

locals {
  cluster_name = var.clusterName
}

########################