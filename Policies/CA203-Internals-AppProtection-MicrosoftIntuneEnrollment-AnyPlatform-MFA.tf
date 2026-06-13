locals {
  ca203 = "CA203-Internals-AppProtection-MicrosoftIntuneEnrollment-AnyPlatform-MFA"
}

resource "azuread_group" "ca203_exclusion" {
  display_name     = "${local.ca203}-Exclusion"
  security_enabled = true
}

resource "azuread_conditional_access_policy" "ca203" {
  display_name = local.ca203
  state        = "enabledForReportingButNotEnforced"

  conditions {
    client_app_types = ["all"]

    applications {
      included_applications = ["d4ebce55-015a-49b5-a083-c84d1797ae8c"] # Microsoft Intune Enrollment
    }

    users {
      included_groups = [azuread_group.internals_persona.object_id]
      excluded_groups = [
        azuread_group.breakglass.object_id,
        azuread_group.ca203_exclusion.object_id
      ]
    }
  }

  grant_controls {
    operator                          = "OR"
    authentication_strength_policy_id = "/policies/authenticationStrengthPolicies/00000000-0000-0000-0000-000000000002" # MFA
  }

  session_controls {
    sign_in_frequency_authentication_type = "primaryAndSecondaryAuthentication"
    sign_in_frequency_interval            = "everyTime"
  }
}
