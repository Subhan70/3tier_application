variable "project_id" {
  description = "GCP Project id"
  type        = string
  default     = "three-tier-multicloud"
}

variable "region" {
  description = "GCP region"
  type        = string
  default     = "us-central1"
}

variable "clusterName" {
  description = "Name of the kubernetes engine cluster"
  type        = string
  default     = "vprofile-gke"
}

variable "ip_range_pods" {
  description = "IP address assigned to pods within the Kubernetes cluster"
  type        = string
  default     = "pods-range"
}

variable "ip_range_services" {
  description = "IP address assigned to services within the Kubernetes cluster"
  type        = string
  default     = "services-range"
}

variable "google_application_credentials" {
  type        = string
}

##