variable "project_id" {
  description = "GCP Project id"
  type        = string
  default     = "three-tier-multicloud"
}

variable "region" {
  description = "GCP region"
  type        = string
  default     = "asia-east1"
}

variable "zone" {
  description = "GCP zone"
  type        = string
  default     = "asia-east1-a"
}

variable "clusterName" {
  description = "Name of the kubernetes engine cluster"
  type        = string
  default     = "multicloud-gke"
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

##