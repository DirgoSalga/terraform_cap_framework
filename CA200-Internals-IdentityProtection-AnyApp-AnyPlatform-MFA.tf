locals {
  ca015 = "CA200-Internals-IdentityProtection-AnyApp-AnyPlatform-MFA"
}

resource "azuread_group" "ca015_exclusion" {
  display_name     = "${local.ca015}-Exclusion"
  security_enabled = true
}

resource "azuread_conditional_access_policy" "ca015" {
  display_name = local.ca015
  state        = "enabledForReportingButNotEnforced"

  conditions {
    client_app_types = ["browser", "mobileAppsAndDesktopClients"]

    applications {
      included_applications = ["All"]
    }

    users {
      included_groups = ["ceeac9b8-ddf5-48cb-afcb-e2ab8bfd1a57"]
      excluded_groups = concat(
        ["cfa1f128-ec48-4ee1-9ea9-1c28fdb57722", "2802b872-ccfb-4b29-a9a9-459808dfb11b"],
        [azuread_group.ca015_exclusion.object_id]
      )
    }

    locations {
      included_locations = ["All"]
    }
  }

  grant_controls {
    operator = "OR"
    built_in_controls = ["mfa"]
  }
}
