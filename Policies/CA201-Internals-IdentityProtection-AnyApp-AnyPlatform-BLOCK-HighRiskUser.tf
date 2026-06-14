locals {
  ca201 = "CA201-Internals-IdentityProtection-AnyApp-AnyPlatform-BLOCK-HighRiskUser"
}

resource "azuread_group" "ca201_exclusion" {
  display_name     = "${local.ca201}-Exclusion"
  security_enabled = true
}

resource "azuread_conditional_access_policy" "ca201" {
  display_name = local.ca201
  state        = "enabledForReportingButNotEnforced"

  conditions {
    client_app_types = ["all"]
    user_risk_levels = ["high"]

    applications {
      included_applications = ["All"]
    }

    users {
      included_groups = [var.internals_persona_group_object_id]
      excluded_groups = [
        var.breakglass_group_object_id,
        azuread_group.ca201_exclusion.object_id
      ]
    }
  }

  grant_controls {
    operator          = "OR"
    built_in_controls = ["block"]
  }
}
