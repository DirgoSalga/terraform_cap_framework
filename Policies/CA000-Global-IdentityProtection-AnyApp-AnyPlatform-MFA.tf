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
      excluded_groups = [
          azuread_group.ca000_exclusion.object_id,
          azuread_group.ca0100_exclusion.object_id,
          azuread_group.ca014_exclusion.object_id,
          azuread_group.ca015_exclusion.object_id,
          azuread_group.ca018_exclusion.object_id,
          azuread_group.ca026_exclusion.object_id,
          azuread_group.ca028_exclusion.object_id,
        ]
    }
  }

  grant_controls {
    operator = "OR"
    built_in_controls = ["mfa"]
  }
}
