locals {
  ca403 = "CA403-GuestUsers-IdentityProtection-AllApps-AnyPlatform-PersistentBrowser"
}

resource "azuread_group" "ca403_exclusion" {
  display_name     = "${local.ca403}-Exclusion"
  security_enabled = true
}

resource "azuread_conditional_access_policy" "ca403" {
  display_name = local.ca403
  state        = "enabledForReportingButNotEnforced"

  conditions {
    client_app_types = ["browser"]

    applications {
      included_applications = ["All"]
    }

    users {
      excluded_groups = [
        var.breakglass_group_object_id,
        azuread_group.ca403_exclusion.object_id
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
    persistent_browser_mode = "never"
  }
}
