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
      excluded_groups = concat(
        ["6499f521-8620-4f4e-92a1-db47c79362e8", "2802b872-ccfb-4b29-a9a9-459808dfb11b", "813e2655-e8b9-4255-91f5-7761ee2824bb"],
        [azuread_group.ca001_exclusion.object_id]
      )
    }

    locations {
      included_locations = ["All"]
      excluded_locations = ["185c993e-10a9-44fa-98d1-230c8f72f497"]
    }
  }

  grant_controls {
    operator = "OR"
    built_in_controls = ["block"]
  }
}
