locals {
  ca027 = "CA301-ServiceAccounts-AttackSurfaceReduction-AllApps-AnyPlatform-BlockUntrustedLocations"
}

resource "azuread_group" "ca027_exclusion" {
  display_name     = "${local.ca027}-Exclusion"
  security_enabled = true
}

resource "azuread_conditional_access_policy" "ca027" {
  display_name = local.ca027
  state        = "enabledForReportingButNotEnforced"

  conditions {
    client_app_types = ["all"]

    applications {
      included_applications = ["All"]
    }

    users {
      included_groups = ["77c1ed37-10d0-4ef1-93dc-198e70abb166"]
      excluded_groups = concat(
        ["813e2655-e8b9-4255-91f5-7761ee2824bb"],
        [azuread_group.ca027_exclusion.object_id]
      )
    }

    locations {
      included_locations = ["All"]
      excluded_locations = ["1cc7e30b-f894-43a2-9da6-30aa7c085dda"]
    }
  }

  grant_controls {
    operator = "OR"
    built_in_controls = ["block"]
  }
}
