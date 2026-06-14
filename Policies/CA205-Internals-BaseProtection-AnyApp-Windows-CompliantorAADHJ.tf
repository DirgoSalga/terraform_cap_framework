locals {
  ca205 = "CA205-Internals-BaseProtection-AnyApp-Windows-CompliantorAADHJ"
}

resource "azuread_group" "ca205_exclusion" {
  display_name     = "${local.ca205}-Exclusion"
  security_enabled = true
}

resource "azuread_conditional_access_policy" "ca205" {
  display_name = local.ca205
  state        = "enabledForReportingButNotEnforced"

  conditions {
    client_app_types = ["all"]

    applications {
      included_applications = ["All"]
      excluded_applications = ["0000000a-0000-0000-c000-000000000000", "d4ebce55-015a-49b5-a083-c84d1797ae8c"]
    }

    users {
      included_groups = [var.internals_persona_group_object_id]
      excluded_groups = [
        var.breakglass_group_object_id,
        azuread_group.ca205_exclusion.object_id
      ]
    }

    platforms {
      included_platforms = ["windows"]
    }
  }

  grant_controls {
    operator          = "OR"
    built_in_controls = ["compliantDevice", "domainJoinedDevice"]
  }
}
