resource "azurerm_resource_group" "k8s" {
  name     = "k8s-${var.env}"
  location = "West Europe"
}

resource "azurerm_kubernetes_cluster" "k8s" {
  name                = "k8s-${var.env}"
  location            = azurerm_resource_group.k8s.location
  resource_group_name = azurerm_resource_group.k8s.name
  dns_prefix          = "k8s"
  kubernetes_version  = "1.12.6"

  linux_profile {
    admin_username = "ansible"

    ssh_key {
      key_data = var.ssh_pub_key
    }
  }

  agent_pool_profile {
    name            = "default"
    count           = var.node_count
    vm_size         = var.vm_size
    os_type         = "Linux"
    os_disk_size_gb = var.os_disk_size_in_gb
    vnet_subnet_id  = var.vnet_subnet_id
  }

  service_principal {
    client_id     = var.service_principal_id
    client_secret = var.service_principal_secret
  }

  network_profile {
    network_plugin     = "azure"
    dns_service_ip     = "10.0.0.10"
    docker_bridge_cidr = "172.17.0.1/16"
    service_cidr       = "10.0.0.0/16"
  }

  tags {
    Environment = var.env
  }
}
