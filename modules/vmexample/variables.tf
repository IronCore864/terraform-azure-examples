variable "vmexample_rg_name" {
  description = "Name of the vmexample resource group. Example: dev-vmexample"
}

variable "env" {
  description = "Environment identifier. Example: dev/prod"
}

variable "frontend_subnet_id" {}

variable "ansible_user_name" {
  default = "ansible"
}

variable "vm_size" {
  default = "Standard_D2S_v3"
}

variable "ansible_pub_key" {
  description = "Public key of ansible user, used for passwordless ssh."
}
