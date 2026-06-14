locals {
  ca204 = "CA204-Internals-AttackSurfaceReduction-AllApps-AnyPlatform-BlockUnknownPlatforms"
}

resource "azuread_group" "ca204_exclusion" {
  display_name     = "${local.ca204}-Exclusion"
  security_enabled = true
}

resource "azuread_conditional_access_policy" "ca204" {
  display_name = local.ca204
  state        = "enabledForReportingButNotEnforced"

  conditions {
    client_app_types = ["all"]

    applications {
      included_applications = ["All"]
    }

    users {
      included_groups = [var.internals_persona_group_object_id]
      excluded_groups = [
        var.breakglass_group_object_id,
        azuread_group.ca204_exclusion.object_id
      ]
    }

    platforms {
      included_platforms = ["all"]
      excluded_platforms = ["android", "iOS", "windows", "macOS"]
    }
  }

  grant_controls {
    operator          = "OR"
    built_in_controls = ["block"]
  }
}
