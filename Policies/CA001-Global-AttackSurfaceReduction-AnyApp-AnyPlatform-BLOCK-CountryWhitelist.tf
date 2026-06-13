locals {
  ca001 = "CA001-Global-AttackSurfaceReduction-AnyApp-AnyPlatform-BLOCK-CountryWhitelist"
}

resource "azuread_group" "ca001_exclusion" {
  display_name     = "${local.ca001}-Exclusion"
  security_enabled = true
}

resource "azuread_conditional_access_policy" "ca001" {
  display_name = local.ca001
  state        = "enabledForReportingButNotEnforced"

  conditions {
    client_app_types = ["all"]

    applications {
      included_applications = ["All"]
    }

    users {
      included_users = ["All"]
      excluded_groups = [
        azuread_group.breakglass.object_id,
        azuread_group.ca001_exclusion.object_id
      ]
    }

    locations {
      included_locations = ["All"]
      excluded_locations = [azuread_named_location.eu.id]
    }
  }

  grant_controls {
    operator          = "OR"
    built_in_controls = ["block"]
  }
}
