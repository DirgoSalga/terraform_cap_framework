locals {
  ca208 = "CA208-Internals-IdentityProtection-AnyApp-AnyPlatform-BLOCK-HighRiskSignIn"
}

resource "azuread_group" "ca208_exclusion" {
  display_name     = "${local.ca208}-Exclusion"
  security_enabled = true
}

resource "azuread_conditional_access_policy" "ca208" {
  display_name = local.ca208
  state        = "enabledForReportingButNotEnforced"

  conditions {
    client_app_types    = ["all"]
    sign_in_risk_levels = ["high"]

    applications {
      included_applications = ["All"]
    }

    users {
      included_groups = [azuread_group.internals_persona.object_id]
      excluded_groups = [
        azuread_group.breakglass.object_id,
        azuread_group.ca208_exclusion.object_id
      ]
    }
  }

  grant_controls {
    operator          = "OR"
    built_in_controls = ["block"]
  }
}
