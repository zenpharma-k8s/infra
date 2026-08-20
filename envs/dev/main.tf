data "azurerm_client_config" "current" {}
module "network" {
  source = "../../modules/virtual-network"

  resource_group_name = var.resource_group_name
  location            = var.location

  vnet_name           = var.vnet_name
  vnet_address_space  = var.vnet_address_space

  subnets = var.subnets

  tags = var.tags
}

module "key_vault" {
  source = "../../modules/key-vault"

  key_vault_name      = var.key_vault_name
  location            = var.location
  resource_group_name = azurerm_resource_group.this.name
  tenant_id           = data.azurerm_client_config.current.tenant_id

  tags = {
    Project     = var.project
    Environment = var.environment
    ManagedBy   = "Terraform"
  }
}

# module "aks" {
#   source = "../../modules/aks"

#   cluster_name       = var.aks_cluster_name
#   location           = var.location
#   resource_group_name = azurerm_resource_group.this.name

#   dns_prefix         = var.aks_dns_prefix
#   kubernetes_version  = var.kubernetes_version

#   system_vm_size     = var.system_vm_size
#   system_node_count  = var.system_node_count
#   system_subnet_id   = module.network.aks_subnet_id
#   os_disk_size_gb    = 128

#   service_cidr       = var.service_cidr
#   dns_service_ip     = var.dns_service_ip

#   log_analytics_workspace_id = azurerm_log_analytics_workspace.this.id

#   tags = {
#     Project     = var.project
#     Environment = var.environment
#     ManagedBy   = "Terraform"
#   }
# }

module "identity" {
  source = "../../modules/identity"

  project             = var.project
  environment         = var.environment
  location            = var.location
  resource_group_name = azurerm_resource_group.this.name

  key_vault_id = module.key_vault.key_vault_id

  aks_oidc_issuer_url = module.aks.oidc_issuer_url

  namespace            = "myapp"
  service_account_name = "myapp-sa"

  tags = {
    Project     = var.project
    Environment = var.environment
    ManagedBy   = "Terraform"
  }
}