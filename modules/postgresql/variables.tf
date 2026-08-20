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
}

variable "resource_group_name" {
  description = "Resource group for the database"
  type        = string
}

variable "vnet_id" {
  description = "VNet ID to link the private DNS zone to"
  type        = string
}

variable "database_subnet_id" {
  description = "ID of the delegated database subnet"
  type        = string
}

variable "db_name" {
  description = "Name of the database to create"
  type        = string
  default     = "pharmadb"
}

variable "username" {
  description = "Administrator username for the server"
  type        = string
}

variable "password" {
  description = "Administrator password for the server"
  type        = string
  sensitive   = true
}

variable "sku_name" {
  description = "Flexible Server compute/storage tier"
  type        = string
  default     = "B_Standard_B1ms"
}

variable "storage_gb" {
  description = "Allocated storage in GB"
  type        = number
  default     = 32
}

variable "multi_az" {
  description = "Enable zone-redundant high availability"
  type        = bool
  default     = false
}

variable "backup_retention_days" {
  description = "Number of days to retain automated backups"
  type        = number
  default     = 7
}

variable "tags" {
  description = "Common resource tags"
  type        = map(string)
  default     = {}
}