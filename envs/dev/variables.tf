# # variable "resource_group_name" {
# #   type        = string
# #   description = "Resource Group name"
# # }

# # variable "location" {
# #   type        = string
# #   description = "Azure region"
# # }

# # variable "vnet_name" {
# #   type        = string
# #   description = "Virtual Network name"
# # }

# # variable "vnet_address_space" {
# #   type        = list(string)
# #   description = "Virtual Network address space"
# # }

# # variable "subnets" {
# #   type = map(object({
# #     name             = string
# #     address_prefixes = list(string)
# #   }))

# #   description = "Subnet configuration"
# # }

# # variable "tags" {
# #   type        = map(string)
# #   description = "Common resource tags"
# #   default     = {}
# # }


# # variable "project" {
# #   description = "Project name"
# #   type        = string
# # }

# # variable "environment" {
# #   description = "Environment name"
# #   type        = string
# #   default     = "dev"
# # }

# variable "subscription_id" {
#   description = "Azure subscription ID"
#   type        = string
# }

variable "db_password" {
  description = "Administrator password for the PostgreSQL Flexible Server"
  type        = string
  sensitive   = true
}

variable "jwt_secret" {
  description = "JWT signing secret for the application"
  type        = string
  sensitive   = true
}

variable "github_org" {
  description = "GitHub username or organization that owns frontend and backend"
  type        = string
  default     = "zenpharma-k8s"
}