output "cluster_name" {
  description = "Micrososft Azure AKS Cluster Name"
  value       = module.aks.aks_name
}

output "cluster_endpoint" {
  description = "Endpoint for Micrososft Azure AKS"
  value       = module.aks.host
}

output "region" {
  description = "Micrososft Azure AKS Cluster region"
  value       = var.region
}

output "subnet_prefixes" {
  value = var.subnet_prefixes
}