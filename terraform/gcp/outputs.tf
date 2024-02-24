output "cluster_name" {
  description = "Google Cloud Platform GKE Cluster Name"
  value       = module.gke.name
}

output "cluster_endpoint" {
  description = "Endpoint for Google Cloud Platform GKE "
  value       = module.gke.endpoint
  sensitive   = true
}

output "region" {
  description = "Google Cloud Platform GKE region"
  value       = var.region
}