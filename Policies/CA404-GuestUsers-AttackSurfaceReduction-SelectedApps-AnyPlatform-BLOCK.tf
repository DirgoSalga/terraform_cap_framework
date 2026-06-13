locals {
  ca032 = "CA404-GuestUsers-AttackSurfaceReduction-SelectedApps-AnyPlatform-BLOCK"
}

resource "azuread_group" "ca032_exclusion" {
  display_name     = "${local.ca032}-Exclusion"
  security_enabled = true
}

resource "azuread_conditional_access_policy" "ca032" {
  display_name = local.ca032
  state        = "enabledForReportingButNotEnforced"

  conditions {
    client_app_types = ["browser", "mobileAppsAndDesktopClients"]

    applications {
      included_applications = ["MicrosoftAdminPortals"]
    }

    users {
      excluded_groups = concat(
        ["2802b872-ccfb-4b29-a9a9-459808dfb11b", "86e8b29d-f7f2-4962-8a2d-65b8f0e5602f"],
        [azuread_group.ca032_exclusion.object_id]
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
    built_in_controls = ["block"]
  }
}
