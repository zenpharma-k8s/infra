resource "azurerm_kubernetes_cluster" "main" {
  name                = "${var.project}-${var.env}-cluster"
  location            = var.location
  resource_group_name = var.resource_group_name
  dns_prefix          = "${var.project}-${var.env}"
  kubernetes_version  = var.kubernetes_version

  default_node_pool {
    name                  = "main"
    vm_size               = var.vm_size
    vnet_subnet_id        = var.subnet_id
    auto_scaling_enabled  = true
    min_count             = var.min_size
    max_count             = var.max_size
    node_count            = var.desired_size
  }

  identity {
    type = "SystemAssigned"
  }

  oidc_issuer_enabled       = true
  workload_identity_enabled = true

  network_profile {
    network_plugin = "azure"
    network_policy = "azure"
  }

  tags = var.tags
}