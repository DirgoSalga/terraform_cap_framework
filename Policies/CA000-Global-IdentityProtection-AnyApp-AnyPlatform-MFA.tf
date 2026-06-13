locals {
  ca000 = "CA000-Global-IdentityProtection-AnyApp-AnyPlatform-MFA"
}

resource "azuread_group" "ca000_exclusion" {
  display_name     = "${local.ca000}-Exclusion"
  security_enabled = true
}

resource "azuread_conditional_access_policy" "ca000" {
  display_name = local.ca000
  state        = "enabledForReportingButNotEnforced"

  conditions {
    client_app_types = ["all"]

    applications {
      included_applications = ["All"]
    }

    users {
      included_users = ["All"]
      excluded_roles = [] # Exclude directory synchronization roles if needed
      excluded_groups = [
          azuread_group.breakglass.object_id,
          azuread_group.ca000_exclusion.object_id,
          azuread_group.ca101_exclusion.object_id,
          azuread_group.ca105_exclusion.object_id,
          azuread_group.ca200_exclusion.object_id,
          azuread_group.ca300_exclusion.object_id,
          azuread_group.ca400_exclusion.object_id,
        ]
    }
  }

  grant_controls {
    operator = "OR"
    authentication_strength_policy_id = "/policies/authenticationStrengthPolicies/00000000-0000-0000-0000-000000000002" # MFA
  }
}
