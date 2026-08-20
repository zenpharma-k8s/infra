output "workload_identity_client_id" {
  description = "Client ID of the Key Vault workload managed identity"
  value       = azurerm_user_assigned_identity.key_vault_workload.client_id
}

output "workload_identity_principal_id" {
  description = "Principal ID of the Key Vault workload managed identity"
  value       = azurerm_user_assigned_identity.key_vault_workload.principal_id
}

output "workload_identity_id" {
  description = "Resource ID of the Key Vault workload managed identity"
  value       = azurerm_user_assigned_identity.key_vault_workload.id
}