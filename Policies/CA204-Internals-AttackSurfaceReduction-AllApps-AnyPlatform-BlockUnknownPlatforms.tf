locals {
  ca019 = "CA204-Internals-AttackSurfaceReduction-AllApps-AnyPlatform-BlockUnknownPlatforms"
}

resource "azuread_group" "ca019_exclusion" {
  display_name     = "${local.ca019}-Exclusion"
  security_enabled = true
}

resource "azuread_conditional_access_policy" "ca019" {
  display_name = local.ca019
  state        = "enabledForReportingButNotEnforced"

  conditions {
    client_app_types = ["all"]

    applications {
      included_applications = ["All"]
    }

    users {
      included_groups = ["ceeac9b8-ddf5-48cb-afcb-e2ab8bfd1a57"]
      excluded_groups = concat(
        ["2802b872-ccfb-4b29-a9a9-459808dfb11b", "5002e94c-71d0-49ef-9633-b15168b0774c"],
        [azuread_group.ca019_exclusion.object_id]
      )
    }

    platforms {
      included_platforms = ["all"]
      excluded_platforms = ["android", "iOS", "windows", "macOS"]
    }
  }

  grant_controls {
    operator = "OR"
    built_in_controls = ["block"]
  }
}
