# output "eso_client_id" {
#   description = "Client ID of the External Secrets Operator identity"
#   value       = azurerm_user_assigned_identity.eso.client_id
# }

# output "argocd_client_id" {
#   description = "Client ID of the ArgoCD identity"
#   value       = azurerm_user_assigned_identity.argocd.client_id
# }

# output "ingress_client_id" {
#   description = "Client ID of the ingress controller identity"
#   value       = azurerm_user_assigned_identity.ingress.client_id
# }

# output "github_actions_client_id" {
#   description = "Client ID for GitHub Actions to use with azure/login"
#   value       = azurerm_user_assigned_identity.github_actions_ci.client_id
# }