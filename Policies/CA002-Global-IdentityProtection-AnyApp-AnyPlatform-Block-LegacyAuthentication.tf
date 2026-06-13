locals {
  ca002 = "CA002-Global-IdentityProtection-AnyApp-AnyPlatform-Block-LegacyAuthentication"
}

resource "azuread_group" "ca002_exclusion" {
  display_name     = "${local.ca002}-Exclusion"
  security_enabled = true
}

resource "azuread_conditional_access_policy" "ca002" {
  display_name = local.ca002
  state        = "enabledForReportingButNotEnforced"

  conditions {
    client_app_types = ["exchangeActiveSync", "other"]

    applications {
      included_applications = ["All"]
    }

    users {
      included_users = ["All"]
      excluded_groups = [
        azuread_group.breakglass.object_id,
        azuread_group.ca002_exclusion.object_id
      ]
    }
  }

  grant_controls {
    operator          = "OR"
    built_in_controls = ["block"]
  }
}
