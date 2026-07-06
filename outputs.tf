output "hpc_cache_access_policies" {
  description = "All hpc_cache_access_policy resources"
  value       = azurerm_hpc_cache_access_policy.hpc_cache_access_policies
}
output "hpc_cache_access_policies_access_rule" {
  description = "List of access_rule values across all hpc_cache_access_policies"
  value       = [for k, v in azurerm_hpc_cache_access_policy.hpc_cache_access_policies : v.access_rule]
}
output "hpc_cache_access_policies_hpc_cache_id" {
  description = "List of hpc_cache_id values across all hpc_cache_access_policies"
  value       = [for k, v in azurerm_hpc_cache_access_policy.hpc_cache_access_policies : v.hpc_cache_id]
}
output "hpc_cache_access_policies_name" {
  description = "List of name values across all hpc_cache_access_policies"
  value       = [for k, v in azurerm_hpc_cache_access_policy.hpc_cache_access_policies : v.name]
}

