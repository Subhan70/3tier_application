module "aks" {
  source  = "Azure/aks/azurerm"
  version = "7.5.0"

  prefix              = var.prefix
  resource_group_name = azurerm_resource_group.resource-grp.name
  os_disk_size_gb     = 60
  sku_tier            = "Standard"
  vnet_subnet_id      = azurerm_subnet.az-subnets.id
  role_based_access_control_enabled = true
  node_pools          = {
    one = {
      name                  = "node-1"
      vm_size               = "Standard_D2s_v3"
      node_count            = 2
      vnet_subnet_id        = azurerm_subnet.az-subnets.id
      max_count = 3
      min_count             = 1
    }
    two = {
      name                  = "node-2"
      vm_size               = "Standard_D2s_v3"
      node_count            = 1
      vnet_subnet_id        = azurerm_subnet.az-subnets.id
      max_count = 2
      min_count             = 1
    }
  }
}