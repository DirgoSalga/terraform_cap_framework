resource "azuread_user" "breakglass_1" {
  user_principal_name = var.breakglass_upn_1
  display_name        = "Emergency Access 1"
  account_enabled     = true
  disable_password_expiration = true

  # Set a strong initial password. Rotate this immediately after first use
  # and store it securely in a vault, not in source control.
  password = "ChangeMe!InitialP@sswd1"
}

resource "azuread_user" "breakglass_2" {
  user_principal_name = var.breakglass_upn_2
  display_name        = "Emergency Access 2"
  account_enabled     = true
  disable_password_expiration = true

  password = "ChangeMe!InitialP@sswd2"
}

data "azuread_client_config" "current" {}

resource "azuread_group" "breakglass" {
  display_name       = var.breakglass_group_name
  description        = "Emergency access accounts excluded from all Conditional Access policies. Handle with care."
  security_enabled   = true
  assignable_to_role = true

  owners = [data.azuread_client_config.current.object_id]

  members = [
    azuread_user.breakglass_1.object_id,
    azuread_user.breakglass_2.object_id,
  ]
}