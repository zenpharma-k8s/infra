resource "azurerm_user_assigned_identity" "key_vault_workload" {
  name                = "${var.project}-${var.environment}-kv-workload-identity"
  location            = var.location
  resource_group_name = var.resource_group_name

  tags = var.tags
}


resource "azurerm_federated_identity_credential" "key_vault_workload" {
  name                = "${var.project}-${var.environment}-kv-federated-credential"

  resource_group_name = var.resource_group_name
  parent_id           = azurerm_user_assigned_identity.key_vault_workload.id

  issuer = var.aks_oidc_issuer_url

  audience = [
    "api://AzureADTokenExchange"
  ]

  subject = "system:serviceaccount:${var.namespace}:${var.service_account_name}"
}


resource "azurerm_role_assignment" "key_vault_secrets_user" {
  scope                = var.key_vault_id

  role_definition_name = "Key Vault Secrets User"

  principal_id = azurerm_user_assigned_identity.key_vault_workload.principal_id
}