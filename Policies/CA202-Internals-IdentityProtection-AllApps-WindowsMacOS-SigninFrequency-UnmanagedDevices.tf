locals {
  ca202 = "CA202-Internals-IdentityProtection-AllApps-WindowsMacOS-SigninFrequency-UnmanagedDevices"
}

resource "azuread_group" "ca202_exclusion" {
  display_name     = "${local.ca202}-Exclusion"
  security_enabled = true
}

resource "azuread_conditional_access_policy" "ca202" {
  display_name = local.ca202
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
        azuread_group.ca202_exclusion.object_id
      ]
    }

    platforms {
      included_platforms = ["windows", "macOS"]
    }

    devices {
      filter {
        mode = "exclude"
        rule = "device.deviceOwnership -eq \"Company\" -or device.isCompliant -eq True"
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
