output "postgres_fqdn" {
  description = "PostgreSQL Flexible Server FQDN"
  value       = module.postgresql.server_fqdn
}

output "aks_cluster_name" {
  description = "AKS cluster name"
  value       = module.aks.cluster_name
}