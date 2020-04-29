locals {
  keys = [
    "vmexample${var.env}",
    "environment",
  ]

  values = [
    "",
    "${var.env}",
  ]
}

resource "azurerm_resource_group" "vmexample" {
  name     = var.vmexample_rg_name
  location = "West Europe"
}

resource "azurerm_network_security_group" "vmexample" {
  name                = "vmexample-${var.env}"
  location            = azurerm_resource_group.vmexample.location
  resource_group_name = azurerm_resource_group.vmexample.name

  security_rule {
    name                       = "vmexample"
    priority                   = 110
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "80"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

resource "azurerm_network_interface" "vmexample" {
  name                      = "vmexample-${var.env}"
  location                  = azurerm_resource_group.vmexample.location
  resource_group_name       = azurerm_resource_group.vmexample.name
  network_security_group_id = azurerm_network_security_group.vmexample.id

  ip_configuration {
    name = "privateconfiguration"

    subnet_id                     = var.frontend_subnet_id
    private_ip_address_allocation = "dynamic"
  }
}

resource "azurerm_virtual_machine" "vmexample" {
  name                  = "vmexample-${var.env}"
  location              = azurerm_resource_group.vmexample.location
  resource_group_name   = azurerm_resource_group.vmexample.name
  vm_size               = var.vm_size
  network_interface_ids = [azurerm_network_interface.vmexample.id]

  delete_os_disk_on_termination    = true
  delete_data_disks_on_termination = true

  storage_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "16.04-LTS"
    version   = "latest"
  }

  storage_os_disk {
    name              = "vmexampledisk1"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }

  os_profile {
    computer_name  = "vmexample"
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
