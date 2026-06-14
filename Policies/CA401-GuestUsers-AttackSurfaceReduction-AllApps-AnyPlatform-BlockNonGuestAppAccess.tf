locals {
  ca401 = "CA401-GuestUsers-AttackSurfaceReduction-AllApps-AnyPlatform-BlockNonGuestAppAccess"
}

resource "azuread_group" "ca401_exclusion" {
  display_name     = "${local.ca401}-Exclusion"
  security_enabled = true
}

resource "azuread_conditional_access_policy" "ca401" {
  display_name = local.ca401
  state        = "enabledForReportingButNotEnforced"

  conditions {
    client_app_types = ["all"]

    applications {
      included_applications = ["All"]
      excluded_applications = [
        "2793995e-0a7d-40d7-bd35-6968ba142197", # MyApps
        "Office365",
      ]
    }

    users {
      excluded_groups = [
        var.breakglass_group_object_id,
        azuread_group.ca401_exclusion.object_id
      ]
      included_guests_or_external_users {
        guest_or_external_user_types = ["internalGuest", "b2bCollaborationGuest", "b2bCollaborationMember", "b2bDirectConnectUser", "otherExternalUser"]
        external_tenants {
          membership_kind = "all"
        }
      }
    }
  }

  grant_controls {
    operator          = "OR"
    built_in_controls = ["block"]
  }
}
