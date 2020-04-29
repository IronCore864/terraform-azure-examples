variable "network_rg_name" {
  description = "Name of the Network resource group. Example: dev-network"
}

variable "env" {
  description = "Environment identifier. Example: dev/prod"
}

variable "addr_space" {
  default     = "172.16.0.0/16"
  description = "The address space for the network. E.g.: 172.16.0.0/16"
}

variable "gateway_subnet_addr_space" {
  default     = "172.16.0.0/28"
  description = "The address space for the gateway subnet. E.g.: 172.16.0.0/28"
}

variable "dmz_subnet_addr_space" {
  default     = "172.16.1.0/24"
  description = "The address space for the dmz subnet. E.g.: 172.16.1.0/24"
}

variable "frontend_subnet_addr_space" {
  default     = "172.16.2.0/24"
  description = "The address space for the frontend subnet. E.g.: 172.16.2.0/24"
}

variable "backend_subnet_addr_space" {
  default     = "172.16.3.0/24"
  description = "The address space for the backend subnet. E.g.: 172.16.3.0/24"
}

variable "infra_subnet_addr_space" {
  default     = "172.16.4.0/24"
  description = "The address space for the infrastructure subnet. E.g.: 172.16.4.0/24"
}

variable "data_subnet_addr_space" {
  default     = "172.16.5.0/24"
  description = "The address space for the data subnet. E.g.: 172.16.5.0/24"
}

variable "vpn_client_addr_space" {
  default     = "10.10.10.0/24"
  description = "The address space for the vpn client."
}

variable "vpn_public_cert_data" {
  description = "The public certificate data for the vpn connection"
}
