variable "project" {
  description = "Project name"
  type        = string
}

variable "env" {
  description = "Environment name (dev, qa, prod)"
  type        = string
}

variable "location" {
  description = "Azure region"
  type        = string
  default     = "eastus"
}

variable "resource_group_name" {
  description = "Resource group to deploy networking into"
  type        = string
}

variable "vnet_cidr" {
  description = "Address space for the VNet"
  type        = string
  default     = "10.0.0.0/16"
}

variable "public_subnet_cidrs" {
  description = "Address prefixes for the public/ingress subnet"
  type        = list(string)
}

variable "private_subnet_cidrs" {
  description = "Address prefixes for the private subnet (AKS nodes)"
  type        = list(string)
}

variable "database_subnet_cidrs" {
  description = "Address prefixes for the delegated database subnet (PostgreSQL Flexible Server)"
  type        = list(string)
}

variable "tags" {
  description = "Common resource tags"
  type        = map(string)
  default     = {}
}