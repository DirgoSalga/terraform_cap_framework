locals {
  ca402 = "CA402-GuestUsers-IdentityProtection-AllApps-AnyPlatform-SigninFrequency"
}

resource "azuread_group" "ca402_exclusion" {
  display_name     = "${local.ca402}-Exclusion"
  security_enabled = true
}

resource "azuread_conditional_access_policy" "ca402" {
  display_name = local.ca402
  state        = "enabledForReportingButNotEnforced"

  conditions {
    client_app_types = ["all"]

    applications {
      included_applications = ["All"]
    }

    users {
      excluded_groups = [
        azuread_group.breakglass.object_id,
        azuread_group.ca402_exclusion.object_id
      ]
      included_guests_or_external_users {
        guest_or_external_user_types = ["internalGuest", "b2bCollaborationGuest", "b2bCollaborationMember", "b2bDirectConnectUser", "otherExternalUser", "serviceProvider"]
        external_tenants {
          membership_kind = "all"
        }
      }
    }
  }

  session_controls {
    sign_in_frequency                     = 12
    sign_in_frequency_period              = "hours"
    sign_in_frequency_authentication_type = "primaryAndSecondaryAuthentication"
    sign_in_frequency_interval            = "timeBased"
  }
}
