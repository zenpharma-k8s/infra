resource "azurerm_key_vault" "main" {
  name                = "${var.project}-${var.env}-kv"  # <= 24 chars, globally unique
  resource_group_name = var.resource_group_name
  location            = var.location
  tenant_id           = var.tenant_id
  sku_name            = "standard"

  enable_rbac_authorization  = true
  purge_protection_enabled   = false  # set true in production
  soft_delete_retention_days = 7

  tags = var.tags
}

# Terraform itself needs a role to write secrets, since enable_rbac_authorization
# replaces the old access-policy model.
resource "azurerm_role_assignment" "terraform_secrets_officer" {
  scope                = azurerm_key_vault.main.id
  role_definition_name = "Key Vault Secrets Officer"
  principal_id          = var.terraform_principal_id
}

resource "azurerm_key_vault_secret" "db_credentials" {
  name         = "${var.project}-${var.env}-db-credentials"
  key_vault_id = azurerm_key_vault.main.id
  value = jsonencode({
    username = var.db_username
    password = var.db_password
    host     = var.db_host
  })

  depends_on = [azurerm_role_assignment.terraform_secrets_officer]
}

resource "azurerm_key_vault_secret" "jwt_secret" {
  name         = "${var.project}-${var.env}-jwt-secret"
  key_vault_id = azurerm_key_vault.main.id
  value = jsonencode({
    secret = var.jwt_secret
  })

  depends_on = [azurerm_role_assignment.terraform_secrets_officer]
}