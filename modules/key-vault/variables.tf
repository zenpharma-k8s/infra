variable "key_vault_name" {
  description = "Name of the Azure Key Vault"
  type        = string
}

variable "location" {
  description = "Azure region"
  type        = string
}

variable "resource_group_name" {
  description = "Resource group containing the Key Vault"
  type        = string
}

variable "tenant_id" {
  description = "Microsoft Entra tenant ID"
  type        = string
}

variable "tags" {
  description = "Tags to apply to the Key Vault"
  type        = map(string)
  default     = {}
}