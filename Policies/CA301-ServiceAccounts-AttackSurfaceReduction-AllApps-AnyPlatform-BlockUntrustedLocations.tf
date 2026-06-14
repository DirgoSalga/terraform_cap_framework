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
      included_groups = [var.service_accounts_persona_group_object_id]
      excluded_groups = [
        var.breakglass_group_object_id,
        azuread_group.ca301_exclusion.object_id
      ]
    }

    locations {
      included_locations = ["All"]
      excluded_locations = [var.eu_named_location_object_id]
    }
  }

  grant_controls {
    operator          = "OR"
    built_in_controls = ["block"]
  }
}
