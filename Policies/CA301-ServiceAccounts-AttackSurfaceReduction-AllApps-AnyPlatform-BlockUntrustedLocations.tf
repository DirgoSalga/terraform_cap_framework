locals {
  ca301 = "CA301-ServiceAccounts-AttackSurfaceReduction-AllApps-AnyPlatform-BlockUntrustedLocations"
}

resource "azuread_group" "ca301_exclusion" {
  display_name     = "${local.ca301}-Exclusion"
  security_enabled = true
}

resource "azuread_conditional_access_policy" "ca301" {
  display_name = local.ca301
  state        = "enabledForReportingButNotEnforced"

  conditions {
    client_app_types = ["all"]

    applications {
      included_applications = ["All"]
    }

    users {
      included_groups = [azuread_group.service_accounts_persona.object_id]
      excluded_groups = [
        azuread_group.breakglass.object_id,
        azuread_group.ca301_exclusion.object_id
      ]
    }

    locations {
      included_locations = ["All"]
      excluded_locations = [azuread_named_location.eu.object_id]
    }
  }

  grant_controls {
    operator          = "OR"
    built_in_controls = ["block"]
  }
}
