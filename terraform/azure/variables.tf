variable "resourceGroup" {
  description = "Name of the Azure Resource group"
  type        = string
  default     = "ThreeTierMultiCloud"
}

variable "region" {
  description = "Azure region"
  type        = string
  default     = "eastus"
}

variable "clusterName" {
  description = "Name of the AKS cluster"
  type        = string
  default     = "multicloud-aks"
}

variable "prefix" {
  description = "Prefix for naming resources"
  type        = string
  default     = "multicloud-threetier"
}

variable "use_for_each" {
  description = "Set for each to true for vnet"
  type        = string
  default     = false
}