locals {
  ca031 = "CA403-GuestUsers-IdentityProtection-AllApps-AnyPlatform-PersistentBrowser"
}

resource "azuread_group" "ca031_exclusion" {
  display_name     = "${local.ca031}-Exclusion"
  security_enabled = true
}

resource "azuread_conditional_access_policy" "ca031" {
  display_name = local.ca031
  state        = "enabledForReportingButNotEnforced"

  conditions {
    client_app_types = ["browser"]

    applications {
      included_applications = ["All"]
    }

    users {
      excluded_groups = concat(
        ["2802b872-ccfb-4b29-a9a9-459808dfb11b", "ffba4a95-5986-4d87-804a-1f354533a930"],
        [azuread_group.ca031_exclusion.object_id]
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
    persistent_browser_mode = "never"
  }
}
