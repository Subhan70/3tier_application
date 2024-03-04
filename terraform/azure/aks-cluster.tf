module "aks" {
  source  = "Azure/aks/azurerm"
  version = "7.5.0"

  prefix              = var.prefix
  resource_group_name = var.resourceGroup
  os_disk_size_gb     = 60
  sku_tier            = "Standard"
  vnet_subnet_id      = azurerm_subnet.az-subnet.id
  rbac_aad_client_app_id     = "${azuread_application.client.application_id}"
  rbac_aad_server_app_id     = "${azuread_application.server.application_id}"
  rbac_aad_server_app_secret = "${azuread_service_principal_password.server.value}"
  role_based_access_control_enabled = true
  node_pools          = {
    one = {
      name                  = "node1"
      vm_size               = "Standard_D2s_v3"
      node_count            = 2
      vnet_subnet_id        = azurerm_subnet.az-subnet.id
      max_count = 3
      min_count             = 1
      zones                 = ["1"]
    }
    two = {
      name                  = "node2"
      vm_size               = "Standard_D2s_v3"
      node_count            = 1
      vnet_subnet_id        = azurerm_subnet.az-subnet.id
      max_count = 2
      min_count             = 1
      zones                 = ["1"]
    }
  }
}