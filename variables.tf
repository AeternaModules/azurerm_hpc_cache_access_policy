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
  validation {
    condition = alltrue([
      for k, v in var.hpc_cache_access_policies : (
        alltrue([for item in v.access_rule : (item.filter == null || (length(item.filter) > 0))])
      )
    ])
    error_message = "must not be empty"
  }
  validation {
    condition = alltrue([
      for k, v in var.hpc_cache_access_policies : (
        alltrue([for item in v.access_rule : (item.anonymous_uid == null || (item.anonymous_uid >= 0))])
      )
    ])
    error_message = "must be at least 0"
  }
  validation {
    condition = alltrue([
      for k, v in var.hpc_cache_access_policies : (
        alltrue([for item in v.access_rule : (item.anonymous_gid == null || (item.anonymous_gid >= 0))])
      )
    ])
    error_message = "must be at least 0"
  }
  # Note: 5 additional provider-side validators are enforced at apply time but not mirrored as validation{} blocks here (bespoke or non-mechanically-translatable).
}

