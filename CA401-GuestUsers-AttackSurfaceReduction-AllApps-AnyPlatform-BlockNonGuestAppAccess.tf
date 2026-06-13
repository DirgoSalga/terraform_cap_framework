locals {
  ca029 = "CA401-GuestUsers-AttackSurfaceReduction-AllApps-AnyPlatform-BlockNonGuestAppAccess"
}

resource "azuread_group" "ca029_exclusion" {
  display_name     = "${local.ca029}-Exclusion"
  security_enabled = true
}

resource "azuread_conditional_access_policy" "ca029" {
  display_name = local.ca029
  state        = "enabledForReportingButNotEnforced"

  conditions {
    client_app_types = ["all"]

    applications {
      included_applications = ["All"]
      excluded_applications = ["2793995e-0a7d-40d7-bd35-6968ba142197", "Office365"]
    }

    users {
      excluded_groups = concat(
        ["2802b872-ccfb-4b29-a9a9-459808dfb11b", "dd82b6e5-6500-4616-93ec-c2558ba20813"],
        [azuread_group.ca029_exclusion.object_id]
      )
      included_guests_or_external_users {
        guest_or_external_user_types = ["internalGuest", "b2bCollaborationGuest", "b2bCollaborationMember", "b2bDirectConnectUser", "otherExternalUser"]
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
