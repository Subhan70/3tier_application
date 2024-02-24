variable "region" {
  description = "Azure region"
  type        = string
  default     = "eastus"
}

variable "clusterName" {
  description = "Name of the AKS cluster"
  type        = string
  default     = "vprofile-aks"
}

variable "prefix" {
  description = "Prefix for naming resources"
  type        = string
  default     = "three-tier-multicloud"
}

variable "use_for_each" {
  description = "Set for each to true for vnet"
  type        = string
  default     = true
}