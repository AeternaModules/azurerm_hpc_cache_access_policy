resource "azurerm_hpc_cache_access_policy" "hpc_cache_access_policys" {
  for_each = var.hpc_cache_access_policys

  hpc_cache_id = each.value.hpc_cache_id
  name         = each.value.name

  dynamic "access_rule" {
    for_each = each.value.access_rule
    content {
      access                  = access_rule.value.access
      anonymous_gid           = access_rule.value.anonymous_gid
      anonymous_uid           = access_rule.value.anonymous_uid
      filter                  = access_rule.value.filter
      root_squash_enabled     = access_rule.value.root_squash_enabled
      scope                   = access_rule.value.scope
      submount_access_enabled = access_rule.value.submount_access_enabled
      suid_enabled            = access_rule.value.suid_enabled
    }
  }
}

