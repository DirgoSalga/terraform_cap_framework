locals {
  ca025 = "CA210-Internals-IdentityProtection-AnyApp-AnyPlatform-BLOCK-HighRiskSignIn"
}

resource "azuread_group" "ca025_exclusion" {
  display_name     = "${local.ca025}-Exclusion"
  security_enabled = true
}

resource "azuread_conditional_access_policy" "ca025" {
  display_name = local.ca025
  state        = "enabledForReportingButNotEnforced"

  conditions {
    client_app_types = ["all"]
    sign_in_risk_levels = ["high"]

    applications {
      included_applications = ["All"]
    }

    users {
      included_groups = ["ceeac9b8-ddf5-48cb-afcb-e2ab8bfd1a57"]
      excluded_groups = concat(
        ["2802b872-ccfb-4b29-a9a9-459808dfb11b", "669c1f87-63ac-40c3-8fc2-fcc72e690e68"],
        [azuread_group.ca025_exclusion.object_id]
      )
    }
  }

  grant_controls {
    operator = "OR"
    built_in_controls = ["block"]
  }
}
