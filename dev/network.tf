module "network" {
  source               = "../modules/network"
  network_rg_name      = var.network_rg_name
  env                  = "dev"
  vpn_public_cert_data = var.root_ca_key_data
}

output "gateway_subnet_id" {
  value = module.network.gateway_subnet_id
}

output "dmz_subnet_id" {
  value = module.network.dmz_subnet_id
}

output "frontend_subnet_id" {
  value = module.network.frontend_subnet_id
}

output "backend_subnet_id" {
  value = module.network.backend_subnet_id
}

output "infra_subnet_id" {
  value = module.network.infra_subnet_id
}

output "data_subnet_id" {
  value = module.network.data_subnet_id
}
