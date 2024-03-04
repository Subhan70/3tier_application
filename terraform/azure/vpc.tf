# Creates network security groups
resource "azurerm_network_security_group" "nsg" {
  location            = var.region
  name                = "three-tier-multicloud-nsg"
  resource_group_name = var.resourceGroup
}

# Creates route table
resource "azurerm_route_table" "route-table" {
  location            = var.region
  name                = "three-tier-multicloud-rtable"
  resource_group_name = var.resourceGroup

  route {
    name           = "route-table-all"
    address_prefix = "0.0.0.0/0"
    next_hop_type  = "VnetLocal"
  }
}

# Creates Public ip
resource "azurerm_public_ip" "pip" {
  name                = "three-tier-multicloud-pip"
  location            = var.region
  resource_group_name = var.resourceGroup
  allocation_method   = "Static"
  sku                 = "Standard"
}

# Creates NAT gateway
resource "azurerm_nat_gateway" "nat" {
  name                    = "three-tier-multicloud-nat"
  location                = var.region
  resource_group_name     = var.resourceGroup
  sku_name            = "Standard"
} 

# Associates nat gateway with public ip
resource "azurerm_nat_gateway_public_ip_association" "pia" {
  nat_gateway_id       = azurerm_nat_gateway.nat.id
  public_ip_address_id = azurerm_public_ip.pip.id
}

# Creates DNS Zone
resource "azurerm_dns_zone" "dns-zone" {
  name                = "rrsinfo.xyz"
  resource_group_name = var.resourceGroup
}

# Creates VPC
module "vnet" {
  source  = "Azure/vnet/azurerm"
  version = "4.1.0"
  resource_group_name = var.resourceGroup
  vnet_name = "three-tier-multicloud-vnet"
  use_for_each        = var.use_for_each
  address_space       = ["172.0.0.0/16"]
  subnet_names        = ["public-subnet-1", "public-subnet-2", "public-subnet-3", "private-subnet-1", "private-subnet-2", "private-subnet-3"]
  subnet_prefixes     = ["172.0.1.0/24", "172.0.2.0/24", "172.0.3.0/24", "172.0.4.0/24", "172.0.5.0/24", "172.0.6.0/24"]
  vnet_location       = var.region

  nsg_ids = {
    for subnet in module.vnet.subnet : subnet.name => azurerm_network_security_group.nsg.id
  }

  route_tables_ids = {
    for subnet in module.vnet.subnet : subnet.name => azurerm_route_table.route-table.id
  }

  tags = {
    Name = "Three tier multicloud"
    Technology  = "Terraform"
  }
}

# Create subnet ( Only one subnet can be created as AllowMultipleAddressPrefixesOnSubnet is not yet in public preview)
# resource "azurerm_subnet" "az-subnet" {
#  name                 = "three-tier-multicloud-subnet"
#  resource_group_name  = var.resourceGroup
#  virtual_network_name = module.vnet.vnet_name
#  address_prefixes     = ["172.0.1.0/24"]
#}
#