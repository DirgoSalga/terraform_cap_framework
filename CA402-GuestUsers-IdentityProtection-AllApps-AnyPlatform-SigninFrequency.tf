locals {
  ca030 = "CA402-GuestUsers-IdentityProtection-AllApps-AnyPlatform-SigninFrequency"
}

resource "azuread_group" "ca030_exclusion" {
  display_name     = "${local.ca030}-Exclusion"
  security_enabled = true
}

resource "azuread_conditional_access_policy" "ca030" {
  display_name = local.ca030
  state        = "enabledForReportingButNotEnforced"

  conditions {
    client_app_types = ["all"]

    applications {
      included_applications = ["All"]
    }

    users {
      excluded_groups = concat(
        ["2802b872-ccfb-4b29-a9a9-459808dfb11b", "0e4ab0ed-e589-46ad-80a2-f913b6b6b0ed"],
        [azuread_group.ca030_exclusion.object_id]
      )
      included_guests_or_external_users {
        guest_or_external_user_types = ["internalGuest", "b2bCollaborationGuest", "b2bCollaborationMember", "b2bDirectConnectUser", "otherExternalUser", "serviceProvider"]
        external_tenants {
          membership_kind = "all"
        }
      }
    }
  }

  session_controls {
    sign_in_frequency = 12
    sign_in_frequency_period = "hours"
    sign_in_frequency_authentication_type = "primaryAndSecondaryAuthentication"
    sign_in_frequency_interval = "timeBased"
  }
}
