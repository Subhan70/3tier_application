module "aks" {
  source  = "Azure/aks/azurerm"
  version = "7.5.0"

  prefix              = var.prefix
  resource_group_name = var.resourceGroup
  os_disk_size_gb     = 60
  sku_tier            = "Standard"
  for_each            = data.azurerm_subnet.subnet
  vnet_subnet_id      = each.value.id
  rbac_aad            = false
  node_pools          = {
    one = {
      name                  = "node1"
      vm_size               = "Standard_D2s_v3"
      node_count            = 2
      for_each              = data.azurerm_subnet.subnet
      vnet_subnet_id        = each.value.id
      max_count = 3
      min_count             = 1
      zones                 = ["1"]
    }
    two = {
      name                  = "node2"
      vm_size               = "Standard_D2s_v3"
      node_count            = 1
      for_each              = data.azurerm_subnet.subnet
      vnet_subnet_id        = each.value.id
      max_count = 2
      min_count             = 1
      zones                 = ["1"]
    }
  }

  tags = {
    Name = "Three tier multicloud"
    Technology  = "Terraform"
  }
}