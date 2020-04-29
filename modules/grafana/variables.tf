variable "grafana_rg_name" {
  description = "Name of the Grafana resource group. Example: dev-grafana"
}

variable "env" {
  description = "Environment identifier. Example: dev/prod"
}

variable "infra_subnet_id" {}

variable "ansible_user_name" {
  default = "ansible"
}

variable "vm_size" {
  # https://docs.microsoft.com/en-us/azure/virtual-machines/windows/sizes-general
  default = "Standard_D4s_v3"
}

variable "ansible_pub_key" {
  description = "Public key of ansible user, used for passwordless ssh."
}
