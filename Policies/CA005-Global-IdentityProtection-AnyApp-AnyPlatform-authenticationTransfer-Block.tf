locals {
  ca005 = "CA005-Global-IdentityProtection-AnyApp-AnyPlatform-authenticationTransfer-Block"
}

resource "azuread_group" "ca005_exclusion" {
  display_name     = "${local.ca005}-Exclusion"
  security_enabled = true
}

resource "azuread_conditional_access_policy" "ca005" {
  display_name = local.ca005
  state        = "enabledForReportingButNotEnforced"

  conditions {
    client_app_types                     = ["all"]
    authentication_flow_transfer_methods = ["authenticationTransfer"]

    applications {
      included_applications = ["All"]
    }

    users {
      included_users = ["All"]
      excluded_groups = [
        azuread_group.breakglass.object_id,
        azuread_group.ca005_exclusion.object_id
      ]
    }
  }

  grant_controls {
    operator          = "OR"
    built_in_controls = ["block"]
  }
}
