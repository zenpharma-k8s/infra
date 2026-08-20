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
  description = "Resource group for the vault"
  type        = string
}

variable "tenant_id" {
  description = "Azure AD tenant ID"
  type        = string
}

variable "terraform_principal_id" {
  description = "Object ID of the identity running Terraform (needs Secrets Officer to write secrets)"
  type        = string
}

variable "db_username" {
  description = "Database username to store in Key Vault"
  type        = string
  sensitive   = true
}

variable "db_password" {
  description = "Database password to store in Key Vault"
  type        = string
  sensitive   = true
}

variable "jwt_secret" {
  description = "JWT signing secret to store in Key Vault"
  type        = string
  sensitive   = true
}

variable "db_host" {
  description = "PostgreSQL FQDN to store alongside credentials"
  type        = string
}

variable "tags" {
  description = "Common resource tags"
  type        = map(string)
  default     = {}
}