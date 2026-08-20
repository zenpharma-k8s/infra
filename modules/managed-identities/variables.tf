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
  description = "Resource group to create identities in"
  type        = string
}

variable "aks_oidc_issuer_url" {
  description = "OIDC issuer URL of the AKS cluster"
  type        = string
}

variable "key_vault_id" {
  description = "ID of the Key Vault the ESO identity should read from"
  type        = string
}

variable "acr_id" {
  description = "ID of the ACR registry the GitHub Actions identity should push to"
  type        = string
}

variable "aks_id" {
  description = "ID of the AKS cluster the GitHub Actions identity should deploy to"
  type        = string
}

variable "github_org" {
  description = "GitHub organization or username that owns frontend and backend"
  type        = string
}

variable "tags" {
  description = "Common resource tags"
  type        = map(string)
  default     = {}
}