locals {
  ca400 = "CA400-GuestUsers-IdentityProtection-AnyApp-AnyPlatform-MFA"
}

resource "azuread_group" "ca400_exclusion" {
  display_name     = "${local.ca400}-Exclusion"
  security_enabled = true
}

resource "azuread_conditional_access_policy" "ca400" {
  display_name = local.ca400
  state        = "enabledForReportingButNotEnforced"

  conditions {
    client_app_types = ["all"]

    applications {
      included_applications = ["All"]
    }

    users {
      excluded_groups = [
        azuread_group.breakglass.object_id,
        azuread_group.ca400_exclusion.object_id
      ]
      included_guests_or_external_users {
        guest_or_external_user_types = ["internalGuest", "b2bCollaborationGuest", "b2bCollaborationMember", "b2bDirectConnectUser", "otherExternalUser", "serviceProvider"]
        external_tenants {
          membership_kind = "all"
        }
      }
    }
  }

  grant_controls {
    operator                          = "OR"
    authentication_strength_policy_id = "/policies/authenticationStrengthPolicies/00000000-0000-0000-0000-000000000002" # MFA
  }
}
