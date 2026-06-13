locals {
  ca026 = "CA300-ServiceAccounts-IdentityProtection-AnyApp-AnyPlatform-MFA"
}

resource "azuread_group" "ca026_exclusion" {
  display_name     = "${local.ca026}-Exclusion"
  security_enabled = true
}

resource "azuread_conditional_access_policy" "ca026" {
  display_name = local.ca026
  state        = "enabledForReportingButNotEnforced"

  conditions {
    client_app_types = ["browser", "mobileAppsAndDesktopClients"]

    applications {
      included_applications = ["All"]
    }

    users {
      included_groups = ["77c1ed37-10d0-4ef1-93dc-198e70abb166"]
      excluded_groups = concat(
        ["cfa1f128-ec48-4ee1-9ea9-1c28fdb57722", "2802b872-ccfb-4b29-a9a9-459808dfb11b", "70899f87-a5ba-4145-8bd5-2230db5dbbff", "349156c1-2fb1-4ffa-9cd3-5c4418e24e4c", "7452a2db-063a-4048-84b0-ff691fa2900e", "68ce874b-21a9-4ca9-b447-f09a037be53a", "8e75af29-5176-4372-a718-724b8a4620dc"],
        [azuread_group.ca026_exclusion.object_id]
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
