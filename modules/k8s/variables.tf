variable "env" {
  description = "Environment identifier. Example: dev/prod, used as part of resource names"
}

variable "ssh_user" {
  description = "User name of the node"
  default     = "ansible"
}

variable "ssh_pub_key" {
  description = "Public key for ssh login to the k8s node"
}

variable "vnet_subnet_id" {
  description = "In which subnet to deploy the cluster"
}

variable "vm_size" {
  # https://docs.microsoft.com/en-us/azure/virtual-machines/windows/sizes-general
  default = "Standard_D2s_v3"
}

variable "os_disk_size_in_gb" {
  default = 30
}

variable "node_count" {
  default = 3
}

variable "service_principal_id" {}

variable "service_principal_secret" {}
