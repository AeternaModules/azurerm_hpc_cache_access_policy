output "hpc_cache_access_policies_id" {
  description = "Map of id values across all hpc_cache_access_policies, keyed the same as var.hpc_cache_access_policies"
  value       = { for k, v in azurerm_hpc_cache_access_policy.hpc_cache_access_policies : k => v.id }
}
output "hpc_cache_access_policies_access_rule" {
  description = "Map of access_rule values across all hpc_cache_access_policies, keyed the same as var.hpc_cache_access_policies"
  value       = { for k, v in azurerm_hpc_cache_access_policy.hpc_cache_access_policies : k => v.access_rule }
}
output "hpc_cache_access_policies_hpc_cache_id" {
  description = "Map of hpc_cache_id values across all hpc_cache_access_policies, keyed the same as var.hpc_cache_access_policies"
  value       = { for k, v in azurerm_hpc_cache_access_policy.hpc_cache_access_policies : k => v.hpc_cache_id }
}
output "hpc_cache_access_policies_name" {
  description = "Map of name values across all hpc_cache_access_policies, keyed the same as var.hpc_cache_access_policies"
  value       = { for k, v in azurerm_hpc_cache_access_policy.hpc_cache_access_policies : k => v.name }
}

