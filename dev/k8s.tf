module "k8s" {
  source                   = "../modules/k8s"
  env                      = var.env
  ssh_pub_key              = var.ansible_pub_key
  vnet_subnet_id           = module.network.backend_subnet_id
  service_principal_id     = var.service_principal_id_for_k8s
  service_principal_secret = var.service_principal_secret_for_k8s
}

output "k8s_host" {
  value = module.k8s.k8s_host
}
