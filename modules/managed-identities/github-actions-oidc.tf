# ─── GitHub Actions Workload Identity Federation ────────────────────────────
#
# Allows GitHub Actions workflows in your repos to obtain Azure AD tokens
# without any long-lived credentials stored in GitHub Secrets.
#
# How it works:
#   1. GitHub mints a short-lived OIDC token per workflow run
#   2. The workflow calls azure/login with client-id / tenant-id / subscription-id
#   3. Azure AD validates the token's issuer + subject against the federated
#      credential below and issues a short-lived access token
#
# NOTE: unlike AWS, each exact repo+branch subject needs its own credential —
# there is no wildcard/StringLike equivalent.

resource "azurerm_user_assigned_identity" "github_actions_ci" {
  name                = "${var.project}-${var.env}-github-actions-identity"
  location            = var.location
  resource_group_name = var.resource_group_name
  tags                = var.tags
}

locals {
  github_actions_subjects = {
    frontend_main    = "repo:${var.github_org}/frontend:ref:refs/heads/main"
    frontend_develop  = "repo:${var.github_org}/frontend:ref:refs/heads/develop"
    backend_main     = "repo:${var.github_org}/backend:ref:refs/heads/main"
    backend_develop   = "repo:${var.github_org}/backend:ref:refs/heads/develop"
  }
}

resource "azurerm_federated_identity_credential" "github_actions" {
  for_each = local.github_actions_subjects

  name                = "${var.project}-${var.env}-gha-${each.key}"
  resource_group_name = var.resource_group_name
  parent_id           = azurerm_user_assigned_identity.github_actions_ci.id
  issuer              = "https://token.actions.githubusercontent.com"
  subject             = each.value
  audience            = ["api://AzureADTokenExchange"]
}

resource "azurerm_role_assignment" "github_actions_acr_push" {
  scope                = var.acr_id
  role_definition_name = "AcrPush"
  principal_id         = azurerm_user_assigned_identity.github_actions_ci.principal_id
}

resource "azurerm_role_assignment" "github_actions_aks_user" {
  scope                = var.aks_id
  role_definition_name = "Azure Kubernetes Service Cluster User Role"
  principal_id         = azurerm_user_assigned_identity.github_actions_ci.principal_id
}