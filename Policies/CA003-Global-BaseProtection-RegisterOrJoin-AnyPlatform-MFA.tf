locals {
  ca003 = "CA003-Global-BaseProtection-RegisterOrJoin-AnyPlatform-MFA"
}

resource "azuread_group" "ca003_exclusion" {
  display_name     = "${local.ca003}-Exclusion"
  security_enabled = true
}

resource "azuread_conditional_access_policy" "ca003" {
  display_name = local.ca003
  state        = "enabledForReportingButNotEnforced"

  conditions {
    client_app_types = ["all"]

    applications {
      included_user_actions = ["urn:user:registerdevice"]
    }

    users {
      included_users = ["All"]
      excluded_groups = [
        azuread_group.breakglass.object_id,
        azuread_group.ca003_exclusion.object_id
      ]
    }
  }

  grant_controls {
    operator = "OR"
    authentication_strength_policy_id = "/policies/authenticationStrengthPolicies/00000000-0000-0000-0000-000000000002" # MFA
  }
}
