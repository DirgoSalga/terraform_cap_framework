locals {
  ca200 = "CA200-Internals-IdentityProtection-AnyApp-AnyPlatform-MFA"
}

resource "azuread_group" "ca200_exclusion" {
  display_name     = "${local.ca200}-Exclusion"
  security_enabled = true
}

resource "azuread_conditional_access_policy" "ca200" {
  display_name = local.ca200
  state        = "enabledForReportingButNotEnforced"

  conditions {
    client_app_types = ["browser", "mobileAppsAndDesktopClients"]

    applications {
      included_applications = ["All"]
    }

    users {
      included_groups = [var.internals_persona_group_object_id]
      excluded_groups = [
        var.breakglass_group_object_id,
        azuread_group.ca200_exclusion.object_id
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
