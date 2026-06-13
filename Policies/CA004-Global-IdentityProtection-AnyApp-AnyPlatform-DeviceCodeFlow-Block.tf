locals {
  ca004 = "CA004-Global-IdentityProtection-AnyApp-AnyPlatform-DeviceCodeFlow-Block"
}

resource "azuread_group" "ca004_exclusion" {
  display_name     = "${local.ca004}-Exclusion"
  security_enabled = true
}

resource "azuread_conditional_access_policy" "ca004" {
  display_name = local.ca004
  state        = "enabledForReportingButNotEnforced"

  conditions {
    client_app_types                     = ["all"]
    authentication_flow_transfer_methods = ["deviceCodeFlow"]

    applications {
      included_applications = ["All"]
    }

    users {
      included_users = ["All"]
      excluded_groups = [
        azuread_group.breakglass.object_id,
        azuread_group.ca004_exclusion.object_id
      ]
    }
  }

  grant_controls {
    operator          = "OR"
    built_in_controls = ["block"]
  }
}
