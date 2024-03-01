# Creates VPC
module "vnet" {
  source  = "Azure/vnet/azurerm"
  version = "4.1.0"
  resource_group_name = var.resourceGroup
  vnet_name = "three-tier-multicloud-vnet"
  use_for_each        = var.use_for_each
#  address_space       = ["172.20.0.0/16"]
  vnet_location       = var.region

  tags = {
    Name = "Three tier multicloud"
    Technology  = "Terraform"
  }
}

# Create subnet-1
 resource "azurerm_subnet" "az-subnets" {
  name                 = "three-tier-multicloud-subnet1"
  resource_group_name  = var.resourceGroup
  virtual_network_name = module.vnet.vnet_name
  address_prefixes     = ["172.20.1.0/24"]
}

# Create subnet-2
 resource "azurerm_subnet" "az-subnets" {
  name                 = "three-tier-multicloud-subnet2"
  resource_group_name  = var.resourceGroup
  virtual_network_name = module.vnet.vnet_name
  address_prefixes     = ["172.20.2.0/24"]
}

# Create subnet-3
 resource "azurerm_subnet" "az-subnets" {
  name                 = "three-tier-multicloud-subnet3"
  resource_group_name  = var.resourceGroup
  virtual_network_name = module.vnet.vnet_name
  address_prefixes     = ["172.20.3.0/24"]
}

# Create subnet-4
 resource "azurerm_subnet" "az-subnets" {
  name                 = "three-tier-multicloud-subnet4"
  resource_group_name  = var.resourceGroup
  virtual_network_name = module.vnet.vnet_name
  address_prefixes     = ["172.20.4.0/24"]
}

# Create subnet-5
 resource "azurerm_subnet" "az-subnets" {
  name                 = "three-tier-multicloud-subnet5"
  resource_group_name  = var.resourceGroup
  virtual_network_name = module.vnet.vnet_name
  address_prefixes     = ["172.20.5.0/24"]
}

# Create subnet-6
 resource "azurerm_subnet" "az-subnets" {
  name                 = "three-tier-multicloud-subnet6"
  resource_group_name  = var.resourceGroup
  virtual_network_name = module.vnet.vnet_name
  address_prefixes     = ["172.20.6.0/24"]
}

# Creates network security groups
resource "azurerm_network_security_group" "nsg" {
  location            = var.region
  name                = "three-tier-multicloud-nsg"
  resource_group_name = var.resourceGroup
}

# Associates network security group with private subnets
resource "azurerm_subnet_network_security_group_association" "snsg" {
  subnet_id                 = azurerm_subnet.az-subnets.id
  network_security_group_id = azurerm_network_security_group.nsg.id
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

# Creates route table
resource "azurerm_route_table" "route-table" {
  location            = var.region
  name                = "MyRouteTable"
  resource_group_name = var.resourceGroup

  route {
    name           = "route-table-all"
    address_prefix = "0.0.0.0/0"
    next_hop_type  = "VnetLocal"
  }
}