output "k8s_host" {
  value = azurerm_kubernetes_cluster.k8s.kube_config.0.host
}
