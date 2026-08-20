variable "resource_group_name" {
  type        = string
  description = "Resource Group name"
}

variable "location" {
  type        = string
  description = "Azure region"
}

variable "vnet_name" {
  type        = string
  description = "Virtual Network name"
}

variable "vnet_address_space" {
  type        = list(string)
  description = "Virtual Network address space"
}

variable "subnets" {
  type = map(object({
    name             = string
    address_prefixes = list(string)
  }))

  description = "Subnet configuration"
}

variable "tags" {
  type        = map(string)
  description = "Common resource tags"
  default     = {}
}

variable "key_vault_name" {
  description = "Globally unique Azure Key Vault name"
  type        = string
}

variable "project" {
  description = "Project name"
  type        = string
}

variable "environment" {
  description = "Environment name"
  type        = string
  default     = "dev"
}