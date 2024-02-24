# Resource group name and location
resource "azurerm_resource_group" "resource-grp" {
  location = var.region
  name     = "Three-tier-multicloud"
}

# Creates VPC
module "vnet" {
  source  = "Azure/vnet/azurerm"
  version = "4.1.0"
  resource_group_name = azurerm_resource_group.resource-grp.name
  vnet_name = "three-tier-multicloud-vnet"
  use_for_each        = var.use_for_each
  address_space       = ["172.20.0.0/16"]
  vnet_location       = var.region

  tags = {
    Name = "Three tier multicloud"
    Technology  = "Terraform"
  }
}

resource "azurerm_virtual_network" "vnetwork" {
  name                = "three-tier-multicloud-vnetwork"
  location            = var.region
  resource_group_name = azurerm_resource_group.resource-grp.name
  address_space       = ["172.20.21.0/16"]
}

# Create subnets
 resource "azurerm_subnet" "az-subnets" {
  name                 = "three-tier-multicloud-subnet"
  resource_group_name  = azurerm_resource_group.resource-grp.name
  virtual_network_name = azurerm_virtual_network.vnetwork.name
  address_prefixes     = ["172.20.1.0/24", "172.20.2.0/24", "172.20.3.0/24", "172.20.4.0/24", "172.20.5.0/24", "172.20.6.0/24"]
 }

# Creates network security groups
resource "azurerm_network_security_group" "nsg" {
  location            = var.region
  name                = "three-tier-multicloud-nsg"
  resource_group_name = azurerm_resource_group.resource-grp.name
}

# Associates network security group with private subnets
resource "azurerm_subnet_network_security_group_association" "snsg" {
  subnet_id                 = azurerm_subnet.az-subnets.id
  network_security_group_id = azurerm_network_security_group.nsg.id
}

# Creates Public ip
resource "azurerm_public_ip" "pip" {
  name                = "three-tier-multicloud-pip"
  location            = azurerm_resource_group.resource-grp.location
  resource_group_name = azurerm_resource_group.resource-grp.name
  allocation_method   = "Static"
  sku                 = "Standard"
}

# Creates NAT gateway
resource "azurerm_nat_gateway" "nat" {
  name                    = "three-tier-multicloud-nat"
  location                = azurerm_resource_group.resource-grp.location
  resource_group_name     = azurerm_resource_group.resource-grp.name
  sku_name            = "Standard"
} 

# Associates nat gateway with public ip
resource "azurerm_nat_gateway_public_ip_association" "pia" {
  nat_gateway_id       = azurerm_nat_gateway.nat.id
  public_ip_address_id = azurerm_public_ip.pip.id
}

# Creates DNS Zone
resource "azurerm_dns_zone" "dns-zone" {
  name                = "rrsinfo.xyz."
  resource_group_name = azurerm_resource_group.resource-grp.name
}