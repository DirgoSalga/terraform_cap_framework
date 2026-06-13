locals {
  ca003 = "CA003-Global-BaseProtection-RegisterOrJoin-AnyPlatform-MFA"
}

resource "azuread_group" "ca003_exclusion" {
  display_name     = "${local.ca003}-Exclusion"
  security_enabled = true
}

resource "azuread_conditional_access_policy" "ca003" {
  display_name = local.ca003
  state        = "enabledForReportingButNotEnforced"

  conditions {
    client_app_types = ["all"]

    applications {
      included_user_actions = ["urn:user:registerdevice"]
    }

    users {
      included_users = ["All"]
      excluded_groups = concat(
        ["2802b872-ccfb-4b29-a9a9-459808dfb11b", "c4906422-18aa-47d8-b808-8c4919b655d8"],
        [azuread_group.ca003_exclusion.object_id]
      )
    }
  }

  grant_controls {
    operator = "OR"
    built_in_controls = ["mfa"]
  }
}
