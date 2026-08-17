module "network" {
  source = "../../modules/virtual-network"

  resource_group_name = var.resource_group_name
  location            = var.location

  vnet_name           = var.vnet_name
  vnet_address_space  = var.vnet_address_space

  subnets = var.subnets

  tags = var.tags
}