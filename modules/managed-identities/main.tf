# ─── External Secrets Operator (ESO) Workload Identity ─────────────────────
# Allows ESO to read secrets from Azure Key Vault

resource "azurerm_user_assigned_identity" "eso" {
  name                = "${var.project}-${var.env}-eso-identity"
  location            = var.location
  resource_group_name = var.resource_group_name
  tags                = var.tags
}

resource "azurerm_federated_identity_credential" "eso" {
  name                = "${var.project}-${var.env}-eso-fic"
  resource_group_name = var.resource_group_name
  parent_id           = azurerm_user_assigned_identity.eso.id
  issuer              = var.aks_oidc_issuer_url
  subject             = "system:serviceaccount:external-secrets:external-secrets"
  audience            = ["api://AzureADTokenExchange"]
}

resource "azurerm_role_assignment" "eso_key_vault_secrets_user" {
  scope                = var.key_vault_id
  role_definition_name = "Key Vault Secrets User"
  principal_id         = azurerm_user_assigned_identity.eso.principal_id
}

# ─── ArgoCD Workload Identity ───────────────────────────────────────────────

resource "azurerm_user_assigned_identity" "argocd" {
  name                = "${var.project}-${var.env}-argocd-identity"
  location            = var.location
  resource_group_name = var.resource_group_name
  tags                = var.tags
}

resource "azurerm_federated_identity_credential" "argocd" {
  name                = "${var.project}-${var.env}-argocd-fic"
  resource_group_name = var.resource_group_name
  parent_id           = azurerm_user_assigned_identity.argocd.id
  issuer              = var.aks_oidc_issuer_url
  subject             = "system:serviceaccount:argocd:argocd-application-controller"
  audience            = ["api://AzureADTokenExchange"]
}

# ─── Ingress Controller Workload Identity ───────────────────────────────────
# Equivalent role to the AWS Load Balancer Controller — manages ingress
# resources (e.g. Application Gateway Ingress Controller / AGIC)

resource "azurerm_user_assigned_identity" "ingress" {
  name                = "${var.project}-${var.env}-ingress-identity"
  location            = var.location
  resource_group_name = var.resource_group_name
  tags                = var.tags
}

resource "azurerm_federated_identity_credential" "ingress" {
  name                = "${var.project}-${var.env}-ingress-fic"
  resource_group_name = var.resource_group_name
  parent_id           = azurerm_user_assigned_identity.ingress.id
  issuer              = var.aks_oidc_issuer_url
  subject             = "system:serviceaccount:kube-system:ingress-azure"
  audience            = ["api://AzureADTokenExchange"]
}

resource "azurerm_role_assignment" "ingress_network_contributor" {
  scope                = var.resource_group_name != "" ? "/subscriptions/${data.azurerm_client_config.current.subscription_id}/resourceGroups/${var.resource_group_name}" : null
  role_definition_name = "Network Contributor"
  principal_id         = azurerm_user_assigned_identity.ingress.principal_id
}

data "azurerm_client_config" "current" {}