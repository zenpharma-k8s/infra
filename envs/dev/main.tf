locals {
  project  = "pharma"
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
  source = "../../modules/vnet"

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