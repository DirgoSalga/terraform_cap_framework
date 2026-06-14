output "breakglass_accounts" {
  description = "Emergency access accounts created by this deployment. Passwords are intentionally not output."
  value = {
    primary = {
      user_principal_name = azuread_user.breakglass_1.user_principal_name
      object_id           = azuread_user.breakglass_1.object_id
    }
    secondary = {
      user_principal_name = azuread_user.breakglass_2.user_principal_name
      object_id           = azuread_user.breakglass_2.object_id
    }
  }
}

output "breakglass_group" {
  description = "Emergency access exclusion group used by the Conditional Access policies."
  value = {
    display_name = azuread_group.breakglass.display_name
    object_id    = azuread_group.breakglass.object_id
  }
}

output "persona_groups" {
  description = "Persona groups used to scope Conditional Access policy assignments."
  value = {
    admins = {
      display_name            = azuread_group.admin_persona.display_name
      object_id               = azuread_group.admin_persona.object_id
      membership_type         = "dynamic"
      dynamic_membership_rule = var.admin_persona_dynamic_membership_rule
    }
    internals = {
      display_name            = azuread_group.internals_persona.display_name
      object_id               = azuread_group.internals_persona.object_id
      membership_type         = "dynamic"
      dynamic_membership_rule = var.internals_persona_dynamic_membership_rule
    }
    service_accounts = {
      display_name      = azuread_group.service_accounts_persona.display_name
      object_id         = azuread_group.service_accounts_persona.object_id
      membership_type   = "assigned"
      member_object_ids = var.service_accounts_persona_member_object_ids
    }
  }
}

output "named_locations" {
  description = "Named locations created for location-based Conditional Access policies."
  value = {
    eu = {
      display_name = azuread_named_location.eu.display_name
      id           = azuread_named_location.eu.id
      object_id    = azuread_named_location.eu.object_id
    }
  }
}

output "conditional_access_policies" {
  description = "Conditional Access policies created by the Policies module, keyed by policy code."
  value       = module.policies.conditional_access_policies
}

output "conditional_access_exclusion_groups" {
  description = "Per-policy exclusion groups created by the Policies module, keyed by policy code."
  value       = module.policies.conditional_access_exclusion_groups
}

output "conditional_access_policy_count" {
  description = "Number of active Conditional Access policies managed by the Policies module."
  value       = length(module.policies.conditional_access_policies)
}
