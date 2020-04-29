resource "azurerm_resource_group" "network" {
  name     = var.network_rg_name
  location = "West Europe"
}

resource "azurerm_virtual_network" "network" {
  name                = "network-${var.env}"
  location            = azurerm_resource_group.network.location
  resource_group_name = azurerm_resource_group.network.name
  address_space       = [var.addr_space]
}

resource "azurerm_subnet" "gateway" {
  name                 = "GatewaySubnet"
  resource_group_name  = azurerm_resource_group.network.name
  virtual_network_name = azurerm_virtual_network.network.name
  address_prefix       = var.gateway_subnet_addr_space
}

resource "azurerm_subnet" "dmz" {
  name                 = "dmz"
  resource_group_name  = azurerm_resource_group.network.name
  virtual_network_name = azurerm_virtual_network.network.name
  address_prefix       = var.dmz_subnet_addr_space
}

resource "azurerm_subnet" "frontend" {
  name                 = "frontend"
  resource_group_name  = azurerm_resource_group.network.name
  virtual_network_name = azurerm_virtual_network.network.name
  address_prefix       = var.frontend_subnet_addr_space
}

resource "azurerm_subnet" "backend" {
  name                 = "backend"
  resource_group_name  = azurerm_resource_group.network.name
  virtual_network_name = azurerm_virtual_network.network.name
  address_prefix       = var.backend_subnet_addr_space
}

resource "azurerm_subnet" "infra" {
  name                 = "infra"
  resource_group_name  = azurerm_resource_group.network.name
  virtual_network_name = azurerm_virtual_network.network.name
  address_prefix       = var.infra_subnet_addr_space
}

resource "azurerm_subnet" "data" {
  name                 = "data"
  resource_group_name  = azurerm_resource_group.network.name
  virtual_network_name = azurerm_virtual_network.network.name
  address_prefix       = var.data_subnet_addr_space
}

resource "azurerm_public_ip" "vpg" {
  name                = "vpg-pip-${var.env}"
  location            = azurerm_resource_group.network.location
  resource_group_name = azurerm_resource_group.network.name
  allocation_method   = "Dynamic"
}

resource "azurerm_virtual_network_gateway" "vpg" {
  name                = "vpg-${var.env}"
  location            = azurerm_resource_group.network.location
  resource_group_name = azurerm_resource_group.network.name
  type                = "Vpn"
  vpn_type            = "RouteBased"
  active_active       = false
  enable_bgp          = false
  sku                 = "VpnGw1"

  ip_configuration {
    public_ip_address_id          = azurerm_public_ip.vpg.id
    private_ip_address_allocation = "Dynamic"
    subnet_id                     = azurerm_subnet.gateway.id
  }

  vpn_client_configuration {
    address_space = [var.vpn_client_addr_space}

    root_certificate {
      name             = "RootCert"
      public_cert_data = var.vpn_public_cert_data
    }

    vpn_client_protocols = ["SSTP", "IkeV2"]
  }
}
