locals {
  ca300 = "CA300-ServiceAccounts-IdentityProtection-AnyApp-AnyPlatform-MFA"
}

resource "azuread_group" "ca300_exclusion" {
  display_name     = "${local.ca300}-Exclusion"
  security_enabled = true
}

resource "azuread_conditional_access_policy" "ca300" {
  display_name = local.ca300
  state        = "enabledForReportingButNotEnforced"

  conditions {
    client_app_types = ["browser", "mobileAppsAndDesktopClients"]

    applications {
      included_applications = ["All"]
    }

    users {
      included_groups = [azuread_group.service_accounts_persona.object_id]
      excluded_groups = [
        azuread_group.breakglass.object_id,
        azuread_group.ca300_exclusion.object_id
      ]
    }

    locations {
      included_locations = ["All"]
    }
  }

  grant_controls {
    operator                          = "OR"
    authentication_strength_policy_id = "/policies/authenticationStrengthPolicies/00000000-0000-0000-0000-000000000002" # MFA
  }
}
