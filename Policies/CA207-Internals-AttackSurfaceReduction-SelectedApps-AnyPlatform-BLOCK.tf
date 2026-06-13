locals {
  ca022 = "CA207-Internals-AttackSurfaceReduction-SelectedApps-AnyPlatform-BLOCK"
}

resource "azuread_group" "ca022_exclusion" {
  display_name     = "${local.ca022}-Exclusion"
  security_enabled = true
}

resource "azuread_conditional_access_policy" "ca022" {
  display_name = local.ca022
  state        = "enabledForReportingButNotEnforced"

  conditions {
    client_app_types = ["browser", "mobileAppsAndDesktopClients"]

    applications {
      included_applications = ["f53895d3-095d-408f-8e93-8f94b391404e"]
      excluded_applications = ["Office365"]
    }

    users {
      included_groups = ["ceeac9b8-ddf5-48cb-afcb-e2ab8bfd1a57"]
      excluded_groups = concat(
        ["2802b872-ccfb-4b29-a9a9-459808dfb11b", "25114fcf-1656-47dc-9b4e-5dd4a2f680d7"],
        [azuread_group.ca022_exclusion.object_id]
      )
    }
  }

  grant_controls {
    operator = "OR"
    built_in_controls = ["block"]
  }
}
