locals {
  ca024 = "CA209-Internals-IdentityProtection-AllApps-AnyPlatform-ContinuousAccessEvaluation"
}

resource "azuread_group" "ca024_exclusion" {
  display_name     = "${local.ca024}-Exclusion"
  security_enabled = true
}

resource "azuread_conditional_access_policy" "ca024" {
  display_name = local.ca024
  state        = "enabledForReportingButNotEnforced"

  conditions {
    client_app_types = ["all"]

    applications {
      included_applications = ["All"]
    }

    users {
      included_groups = ["ceeac9b8-ddf5-48cb-afcb-e2ab8bfd1a57"]
      excluded_groups = concat(
        ["2802b872-ccfb-4b29-a9a9-459808dfb11b", "e7bb9f14-58fa-4a3f-9a7a-3c67cabc8788"],
        [azuread_group.ca024_exclusion.object_id]
      )
    }
  }
}
