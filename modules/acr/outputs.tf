output "login_server" {
  description = "Login server hostname for the registry (e.g. pharmadevacr.azurecr.io)"
  value       = azurerm_container_registry.main.login_server
}

output "id" {
  description = "Resource ID of the registry"
  value       = azurerm_container_registry.main.id
}

output "name" {
  description = "Name of the registry"
  value       = azurerm_container_registry.main.name
}