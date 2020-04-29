resource "azurerm_resource_group" "shared_storage" {
  name     = var.shared_storage_rg_name
  location = "West Europe"
}

resource "azurerm_storage_account" "storage" {
  name                     = "tiexinfileshare${var.env}"
  resource_group_name      = azurerm_resource_group.shared_storage.name
  location                 = azurerm_resource_group.shared_storage.location
  account_tier             = "Standard"
  account_kind             = "StorageV2"
  account_replication_type = "LRS"

  tags {
    environment = "{var.env}"
  }
}

resource "azurerm_storage_share" "share" {
  name                 = "fileshare${var.env}"
  resource_group_name  = azurerm_resource_group.shared_storage.name
  storage_account_name = azurerm_storage_account.storage.name
}
