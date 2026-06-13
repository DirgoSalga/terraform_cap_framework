locals {
  ca028 = "CA400-GuestUsers-IdentityProtection-AnyApp-AnyPlatform-MFA"
}

resource "azuread_group" "ca028_exclusion" {
  display_name     = "${local.ca028}-Exclusion"
  security_enabled = true
}

resource "azuread_conditional_access_policy" "ca028" {
  display_name = local.ca028
  state        = "enabledForReportingButNotEnforced"

  conditions {
    client_app_types = ["all"]

    applications {
      included_applications = ["All"]
    }

    users {
      excluded_groups = concat(
        ["2802b872-ccfb-4b29-a9a9-459808dfb11b", "349156c1-2fb1-4ffa-9cd3-5c4418e24e4c"],
        [azuread_group.ca028_exclusion.object_id]
      )
      included_guests_or_external_users {
        guest_or_external_user_types = ["internalGuest", "b2bCollaborationGuest", "b2bCollaborationMember", "b2bDirectConnectUser", "otherExternalUser", "serviceProvider"]
        external_tenants {
          membership_kind = "all"
        }
      }
    }
  }

  grant_controls {
    operator = "OR"
    built_in_controls = ["mfa"]
  }
}
