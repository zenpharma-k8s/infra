variable "project" {
  description = "Project name"
  type        = string
}

variable "environment" {
  description = "Environment name"
  type        = string
}

variable "location" {
  description = "Azure region"
  type        = string
}

variable "resource_group_name" {
  description = "Resource group containing the managed identity"
  type        = string
}

variable "key_vault_id" {
  description = "Resource ID of the Azure Key Vault"
  type        = string
}

variable "aks_oidc_issuer_url" {
  description = "OIDC issuer URL from AKS"
  type        = string
}

variable "namespace" {
  description = "Kubernetes namespace of the workload"
  type        = string
}

variable "service_account_name" {
  description = "Kubernetes ServiceAccount name"
  type        = string
}

variable "tags" {
  description = "Tags to apply to Azure resources"
  type        = map(string)
  default     = {}
}