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

# Get the subnet ID using the data source
data "azurerm_subnet" "subnet" {
  name                  = ["public-subnet-1", "public-subnet-2", "public-subnet-3", "private-subnet-1", "private-subnet-2", "private-subnet-3"]
  virtual_network_name  = module.vnet.vnet_name
  resource_group_name  = var.resourceGroup
}