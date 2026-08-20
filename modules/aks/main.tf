resource "azurerm_kubernetes_cluster" "this" {
  name                = var.cluster_name
  location            = var.location
  resource_group_name = var.resource_group_name
  dns_prefix          = var.dns_prefix

  kubernetes_version = var.kubernetes_version

  # ------------------------------------------------------------
  # AKS Managed Identity
  # ------------------------------------------------------------

  identity {
    type = "SystemAssigned"
  }

  # ------------------------------------------------------------
  # System Node Pool
  # ------------------------------------------------------------

  default_node_pool {
    name                        = "system"
    vm_size                     = var.system_vm_size
    node_count                  = var.system_node_count
    vnet_subnet_id              = var.system_subnet_id
    os_disk_size_gb             = var.os_disk_size_gb
    temporary_name_for_rotation = "systemtmp"

    type = "VirtualMachineScaleSets"

    upgrade_settings {
      max_surge = "33%"
    }
  }

  # ------------------------------------------------------------
  # Azure CNI networking
  # ------------------------------------------------------------

  network_profile {
    network_plugin    = "azure"
    network_plugin_mode = "overlay"

    network_policy = "azure"

    load_balancer_sku = "standard"

    service_cidr   = var.service_cidr
    dns_service_ip = var.dns_service_ip
  }

  # ------------------------------------------------------------
  # Azure AD / RBAC
  # ------------------------------------------------------------

  role_based_access_control_enabled = true

  azure_active_directory_role_based_access_control {
    #managed                = true
    azure_rbac_enabled     = true
  }

  # ------------------------------------------------------------
  # OIDC + Workload Identity
  # ------------------------------------------------------------

  oidc_issuer_enabled       = true
  workload_identity_enabled = true

  # ------------------------------------------------------------
  # Monitoring
  # ------------------------------------------------------------

  oms_agent {
    log_analytics_workspace_id = var.log_analytics_workspace_id
  }

  # ------------------------------------------------------------
  # Tags
  # ------------------------------------------------------------

  tags = var.tags
}