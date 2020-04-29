module "grafana" {
  source          = "../modules/grafana"
  grafana_rg_name = var.grafana_rg_name
  env             = "dev"
  infra_subnet_id = module.network.infra_subnet_id
  ansible_pub_key = var.ansible_pub_key
}

output "grafana_public_ip" {
  value = module.grafana.public_ip
}
