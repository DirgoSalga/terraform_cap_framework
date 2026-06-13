locals {
  ca004 = "CA004-Global-IdentityProtection-AnyApp-AnyPlatform-AuthenticationFlows"
}

resource "azuread_group" "ca004_exclusion" {
  display_name     = "${local.ca004}-Exclusion"
  security_enabled = true
}

resource "azuread_conditional_access_policy" "ca004" {
  display_name = local.ca004
  state        = "enabledForReportingButNotEnforced"

  conditions {
    client_app_types = ["all"]
    authentication_flow_transfer_methods = ["deviceCodeFlow", "authenticationTransfer"]

    applications {
      included_applications = ["All"]
    }

    users {
      included_users = ["All"]
      excluded_groups = concat(
        ["2802b872-ccfb-4b29-a9a9-459808dfb11b", "f389fc8e-3965-4ae0-aa53-87511ab05f2b"],
        [azuread_group.ca004_exclusion.object_id]
      )
    }
  }

  grant_controls {
    operator = "OR"
    built_in_controls = ["block"]
  }
}
