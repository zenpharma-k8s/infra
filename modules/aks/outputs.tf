output "cluster_id" {
  description = "AKS cluster resource ID"
  value       = azurerm_kubernetes_cluster.this.id
}

output "cluster_name" {
  description = "AKS cluster name"
  value       = azurerm_kubernetes_cluster.this.name
}

output "kube_config" {
  description = "Raw kubeconfig for AKS"
  value       = azurerm_kubernetes_cluster.this.kube_config_raw
  sensitive   = true
}

output "oidc_issuer_url" {
  description = "OIDC issuer URL used for Workload Identity"
  value       = azurerm_kubernetes_cluster.this.oidc_issuer_url
}

output "kubelet_identity_client_id" {
  description = "AKS kubelet managed identity client ID"
  value       = azurerm_kubernetes_cluster.this.kubelet_identity[0].client_id
}

output "kubelet_identity_object_id" {
  description = "AKS kubelet managed identity object ID"
  value       = azurerm_kubernetes_cluster.this.kubelet_identity[0].object_id
}