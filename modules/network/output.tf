output "gateway_subnet_id" {
  value = azurerm_subnet.gateway.id
}

output "dmz_subnet_id" {
  value = azurerm_subnet.dmz.id
}

output "infra_subnet_id" {
  value = azurerm_subnet.infra.id
}

output "frontend_subnet_id" {
  value = azurerm_subnet.frontend.id
}

output "backend_subnet_id" {
  value = azurerm_subnet.backend.id
}

output "data_subnet_id" {
  value = azurerm_subnet.data.id
}
