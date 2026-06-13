resource "azuread_group" "admin_persona" {
  display_name     = var.admin_persona_group_name
  description      = "Dynamic group for accounts in the admin persona."
  security_enabled = true
  types            = ["DynamicMembership"]

  dynamic_membership {
    enabled = true
    rule    = var.admin_persona_dynamic_membership_rule
  }
}

resource "azuread_group" "internals_persona" {
  display_name     = var.internals_persona_group_name
  description      = "Dynamic group for accounts in the internals persona."
  security_enabled = true
  types            = ["DynamicMembership"]

  dynamic_membership {
    enabled = true
    rule    = var.internals_persona_dynamic_membership_rule
  }
}
