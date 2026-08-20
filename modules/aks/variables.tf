variable "cluster_name" {
  description = "AKS cluster name"
  type        = string
}

variable "location" {
  description = "Azure region"
  type        = string
}

variable "resource_group_name" {
  description = "Resource group name"
  type        = string
}

variable "dns_prefix" {
  description = "DNS prefix for the AKS cluster"
  type        = string
}

variable "kubernetes_version" {
  description = "Kubernetes version"
  type        = string
  default     = null
}

variable "system_vm_size" {
  description = "VM size for the system node pool"
  type        = string
  default     = "Standard_D4s_v5"
}

variable "system_node_count" {
  description = "Number of system nodes"
  type        = number
  default     = 2
}

variable "system_subnet_id" {
  description = "Subnet ID for the AKS system node pool"
  type        = string
}

variable "os_disk_size_gb" {
  description = "OS disk size"
  type        = number
  default     = 128
}

variable "service_cidr" {
  description = "Kubernetes service CIDR"
  type        = string
  default     = "10.0.0.0/16"
}

variable "dns_service_ip" {
  description = "Kubernetes DNS service IP"
  type        = string
  default     = "10.0.0.10"
}

variable "log_analytics_workspace_id" {
  description = "Log Analytics workspace ID"
  type        = string
}

variable "tags" {
  description = "Tags for AKS resources"
  type        = map(string)
  default     = {}
}