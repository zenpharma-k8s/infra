output "vnet_id" {
  description = "ID of the VNet"
  value       = azurerm_virtual_network.main.id
}

output "vnet_name" {
  description = "Name of the VNet"
  value       = azurerm_virtual_network.main.name
}

output "public_subnet_id" {
  description = "ID of the public/ingress subnet"
  value       = azurerm_subnet.public.id
}

output "private_subnet_id" {
  description = "ID of the private (AKS) subnet"
  value       = azurerm_subnet.private.id
}

output "database_subnet_id" {
  description = "ID of the delegated database subnet"
  value       = azurerm_subnet.database.id
}