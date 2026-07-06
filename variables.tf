variable "hpc_cache_access_policies" {
  description = <<EOT
Map of hpc_cache_access_policies, attributes below
Required:
    - hpc_cache_id
    - name
    - access_rule (block):
        - access (required)
        - anonymous_gid (optional)
        - anonymous_uid (optional)
        - filter (optional)
        - root_squash_enabled (optional)
        - scope (required)
        - submount_access_enabled (optional)
        - suid_enabled (optional)
EOT

  type = map(object({
    hpc_cache_id = string
    name         = string
    access_rule = list(object({
      access                  = string
      anonymous_gid           = optional(number)
      anonymous_uid           = optional(number)
      filter                  = optional(string)
      root_squash_enabled     = optional(bool)
      scope                   = string
      submount_access_enabled = optional(bool)
      suid_enabled            = optional(bool)
    }))
  }))
  validation {
    condition = alltrue([
      for k, v in var.hpc_cache_access_policies : (
        length(v.access_rule) >= 1 && length(v.access_rule) <= 3
      )
    ])
    error_message = "Each access_rule list must contain between 1 and 3 items"
  }
  # --- Unconfirmed validation candidates, derived from azurerm_hpc_cache_access_policy's provider source ---
  # Not auto-enabled: either a bespoke provider validator we can't safely translate,
  # or a path that crosses a list-typed block (needs its own for_each wrapping).
  # Review, translate into a real validation{} block above, and delete once confirmed.
  # path: name
  #   source:    validation.StringNotInSlice(...) - no translation rule yet, add one
  # path: hpc_cache_id
  #   source:    [from caches.ValidateCacheID] !ok
  # path: hpc_cache_id
  #   source:    [from caches.ValidateCacheID] err != nil
  # path: access_rule.scope
  #   source:    validation.StringInSlice value list is not a literal []string - likely a generated PossibleValuesFor*() helper; resolve separately
  # path: access_rule.access
  #   source:    validation.StringInSlice value list is not a literal []string - likely a generated PossibleValuesFor*() helper; resolve separately
  # path: access_rule.filter
  #   condition: length(value) > 0
  #   message:   must not be empty
  # path: access_rule.anonymous_uid
  #   condition: value >= 0
  #   message:   must be at least 0
  # path: access_rule.anonymous_gid
  #   condition: value >= 0
  #   message:   must be at least 0
}

