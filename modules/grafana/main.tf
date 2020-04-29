locals {
  keys = [
    "grafana${var.env}",
    "environment",
  ]

  values = [
    "",
    "${var.env}",
  ]
}

resource "azurerm_resource_group" "grafana" {
  name     = var.grafana_rg_name
  location = "West Europe"
}

resource "azurerm_public_ip" "grafana" {
  name                = "grafana-${var.env}"
  location            = azurerm_resource_group.grafana.location
  resource_group_name = azurerm_resource_group.grafana.name
  allocation_method   = "Dynamic"
  domain_name_label   = "tiexin-grafana-${var.env}"
}

resource "azurerm_network_security_group" "grafana" {
  name                = "grafana-${var.env}"
  location            = azurerm_resource_group.grafana.location
  resource_group_name = azurerm_resource_group.grafana.name

  security_rule {
    name                       = "SSH"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "Grafana"
    priority                   = 110
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "80"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "Graphite"
    priority                   = 120
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "8080"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "Carbon"
    priority                   = 130
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "2003"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

resource "azurerm_network_interface" "grafana" {
  name                      = "grafana-${var.env}"
  location                  = azurerm_resource_group.grafana.location
  resource_group_name       = azurerm_resource_group.grafana.name
  network_security_group_id = azurerm_network_security_group.grafana.id

  ip_configuration {
    name = "privateconfiguration"

    #terraform import azurerm_subnet.testSubnet /subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/mygroup1/providers/Microsoft.Network/virtualNetworks/myvnet1/subnets/mysubnet1
    subnet_id                     = var.infra_subnet_id
    private_ip_address_allocation = "dynamic"
    public_ip_address_id          = azurerm_public_ip.grafana.id
  }
}

resource "azurerm_virtual_machine" "grafana" {
  name                  = "grafana-${var.env}"
  location              = azurerm_resource_group.grafana.location
  resource_group_name   = azurerm_resource_group.grafana.name
  vm_size               = var.vm_size
  network_interface_ids = [azurerm_network_interface.grafana.id]

  delete_os_disk_on_termination    = true
  delete_data_disks_on_termination = true

  storage_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "16.04-LTS"
    version   = "latest"
  }

  storage_os_disk {
    name              = "grafanadisk1"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }

  os_profile {
    computer_name  = "grafana"
    admin_username = var.ansible_user_name
  }

  os_profile_linux_config {
    disable_password_authentication = true

    ssh_keys {
      path     = "/home/${var.ansible_user_name}/.ssh/authorized_keys"
      key_data = var.ansible_pub_key
    }
  }

  tags = zipmap(local.keys, local.values)
}
