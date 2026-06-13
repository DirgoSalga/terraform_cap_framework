locals {
  ca000 = "CA000-Global-IdentityProtection-AnyApp-AnyPlatform-MFA"
}

resource "azuread_group" "ca000_exclusion" {
  display_name     = "${local.ca000}-Exclusion"
  security_enabled = true
}

resource "azuread_conditional_access_policy" "ca000" {
  display_name = local.ca000
  state        = "enabledForReportingButNotEnforced"

  conditions {
    client_app_types = ["all"]

    applications {
      included_applications = ["All"]
    }

    users {
      included_users = ["All"]
      excluded_roles = ["d29b2b05-8046-44ba-8758-1e26182fcf32"]
      excluded_groups = concat(
        ["8e75af29-5176-4372-a718-724b8a4620dc", "cfa1f128-ec48-4ee1-9ea9-1c28fdb57722", "2eee133e-3427-4860-81b9-057d5b28b022", "349156c1-2fb1-4ffa-9cd3-5c4418e24e4c", "7452a2db-063a-4048-84b0-ff691fa2900e", "2802b872-ccfb-4b29-a9a9-459808dfb11b", "68ce874b-21a9-4ca9-b447-f09a037be53a"],
        [azuread_group.ca000_exclusion.object_id]
      )
    }
  }

  grant_controls {
    operator = "OR"
    built_in_controls = ["mfa"]
  }
}
