locals {
  project  = "zenfarma"
  env      = "dev"
  location = "eastus"

  common_tags = {
    Project   = local.project
    Env       = local.env
    ManagedBy = "terraform"
  }
}

data "azurerm_client_config" "current" {}

resource "azurerm_resource_group" "main" {
  name     = "${local.project}-${local.env}-rg"
  location = local.location
  tags     = local.common_tags
}

module "vnet" {
  source = "../../modules/virtual-network"

  project              = local.project
  env                  = local.env
  location             = local.location
  resource_group_name  = azurerm_resource_group.main.name
  tags                 = local.common_tags

  vnet_cidr              = "10.0.0.0/16"
  public_subnet_cidrs    = ["10.0.1.0/24"]
  private_subnet_cidrs   = ["10.0.3.0/24"]
  database_subnet_cidrs  = ["10.0.5.0/24"]
}

module "aks" {
  source = "../../modules/aks"

  project              = local.project
  env                  = local.env
  location             = local.location
  resource_group_name  = azurerm_resource_group.main.name
  subnet_id            = module.vnet.private_subnet_cidrs
  kubernetes_version   = "1.34"
  vm_size              = "Standard_B2s"
  min_size             = 1
  max_size             = 4
  desired_size         = 3
  tags                 = local.common_tags
}

module "acr" {
  source = "../../modules/acr"

  project              = local.project
  env                  = local.env
  location             = local.location
  resource_group_name  = azurerm_resource_group.main.name
  tags                 = local.common_tags
}

# Let AKS nodes pull from ACR without static credentials
resource "azurerm_role_assignment" "aks_acr_pull" {
  scope                = module.acr.id
  role_definition_name = "AcrPull"
  principal_id         = module.aks.kubelet_identity_object_id
}

module "postgresql" {
  source = "../../modules/postgresql"

  project              = local.project
  env                  = local.env
  location             = local.location
  resource_group_name  = azurerm_resource_group.main.name
  vnet_id              = module.vnet.vnet_id
  database_subnet_id   = module.vnet.database_subnet_id
  username             = "pharmaadmin"
  password             = var.db_password
  tags                 = local.common_tags
}

module "keyvault" {
  source = "../../modules/keyvault"

  project                 = local.project
  env                     = local.env
  location                = local.location
  resource_group_name     = azurerm_resource_group.main.name
  tenant_id               = data.azurerm_client_config.current.tenant_id
  terraform_principal_id  = data.azurerm_client_config.current.object_id
  db_username             = "pharmaadmin"
  db_password             = var.db_password
  db_host                 = module.postgresql.server_fqdn
  jwt_secret              = var.jwt_secret
  tags                    = local.common_tags
}

module "managed_identities" {
  source = "../../modules/managed-identities"

  project              = local.project
  env                  = local.env
  location             = local.location
  resource_group_name  = azurerm_resource_group.main.name
  aks_oidc_issuer_url  = module.aks.oidc_issuer_url
  key_vault_id         = module.keyvault.key_vault_id
  acr_id               = module.acr.id
  aks_id               = module.aks.cluster_id
  github_org           = var.github_org
  tags                 = local.common_tags
}