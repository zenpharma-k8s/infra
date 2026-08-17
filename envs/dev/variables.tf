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