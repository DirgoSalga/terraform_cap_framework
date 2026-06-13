locals {
  ca016 = "CA201-Internals-IdentityProtection-AnyApp-AnyPlatform-BLOCK-HighRiskUser"
}

resource "azuread_group" "ca016_exclusion" {
  display_name     = "${local.ca016}-Exclusion"
  security_enabled = true
}

resource "azuread_conditional_access_policy" "ca016" {
  display_name = local.ca016
  state        = "enabledForReportingButNotEnforced"

  conditions {
    client_app_types = ["all"]
    user_risk_levels = ["high"]

    applications {
      included_applications = ["All"]
    }

    users {
      included_groups = ["ceeac9b8-ddf5-48cb-afcb-e2ab8bfd1a57"]
      excluded_groups = concat(
        ["2802b872-ccfb-4b29-a9a9-459808dfb11b", "c80b6cc8-5981-484b-80f2-da0387fe4393"],
        [azuread_group.ca016_exclusion.object_id]
      )
    }
  }

  grant_controls {
    operator = "OR"
    built_in_controls = ["block"]
  }
}
