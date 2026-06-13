locals {
  ca023 = "CA208-Internals-BaseProtection-AnyApp-MacOS-Compliant"
}

resource "azuread_group" "ca023_exclusion" {
  display_name     = "${local.ca023}-Exclusion"
  security_enabled = true
}

resource "azuread_conditional_access_policy" "ca023" {
  display_name = local.ca023
  state        = "enabledForReportingButNotEnforced"

  conditions {
    client_app_types = ["all"]

    applications {
      included_applications = ["All"]
      excluded_applications = ["0000000a-0000-0000-c000-000000000000", "d4ebce55-015a-49b5-a083-c84d1797ae8c"]
    }

    users {
      included_groups = ["ceeac9b8-ddf5-48cb-afcb-e2ab8bfd1a57"]
      excluded_groups = concat(
        ["2802b872-ccfb-4b29-a9a9-459808dfb11b", "814dd6f8-2cc8-49a7-b360-b4887d686dc3"],
        [azuread_group.ca023_exclusion.object_id]
      )
    }

    platforms {
      included_platforms = ["macOS"]
    }
  }

  grant_controls {
    operator = "OR"
    built_in_controls = ["compliantDevice"]
  }
}
