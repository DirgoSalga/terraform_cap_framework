variable "admin_persona_group_name" {
  description = "Display name for the dynamic admin persona group."
  type        = string
  default     = "CA-Persona-Admins"
}

variable "admin_persona_dynamic_membership_rule" {
  description = "Dynamic membership rule for the admin persona group."
  type        = string
  default     = "(user.userPrincipalName -startsWith \"adm.\") -and (user.userPrincipalName -endsWith \".onmicrosoft.com\")"
}

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
