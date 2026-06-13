locals {
  ca017 = "CA202-Internals-IdentityProtection-AllApps-WindowsMacOS-SigninFrequency-UnmanagedDevices"
}

resource "azuread_group" "ca017_exclusion" {
  display_name     = "${local.ca017}-Exclusion"
  security_enabled = true
}

resource "azuread_conditional_access_policy" "ca017" {
  display_name = local.ca017
  state        = "enabledForReportingButNotEnforced"

  conditions {
    client_app_types = ["all"]

    applications {
      included_applications = ["All"]
    }

    users {
      included_groups = ["ceeac9b8-ddf5-48cb-afcb-e2ab8bfd1a57"]
      excluded_groups = concat(
        ["2802b872-ccfb-4b29-a9a9-459808dfb11b", "663dad60-a2c9-4228-afa5-a39fef078ad7"],
        [azuread_group.ca017_exclusion.object_id]
      )
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
    sign_in_frequency = 12
    sign_in_frequency_period = "hours"
    sign_in_frequency_authentication_type = "primaryAndSecondaryAuthentication"
    sign_in_frequency_interval = "timeBased"
  }
}
