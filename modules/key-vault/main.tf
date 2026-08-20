resource "azurerm_key_vault" "this" {
  name                = var.key_vault_name
  location            = var.location
  resource_group_name = var.resource_group_name
  tenant_id           = var.tenant_id

  sku_name = "standard"

  # Recommended security settings
  purge_protection_enabled   = true
  soft_delete_retention_days = 90

  # Use Azure RBAC instead of legacy Key Vault access policies
  enable_rbac_authorization = true

  tags = var.tags
}