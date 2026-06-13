locals {
  ca021 = "CA206-Internals-IdentityProtection-AllApps-AnyPlatform-PersistentBrowser"
}

resource "azuread_group" "ca021_exclusion" {
  display_name     = "${local.ca021}-Exclusion"
  security_enabled = true
}

resource "azuread_conditional_access_policy" "ca021" {
  display_name = local.ca021
  state        = "enabledForReportingButNotEnforced"

  conditions {
    client_app_types = ["browser"]

    applications {
      included_applications = ["All"]
    }

    users {
      included_groups = ["ceeac9b8-ddf5-48cb-afcb-e2ab8bfd1a57"]
      excluded_groups = concat(
        ["2802b872-ccfb-4b29-a9a9-459808dfb11b", "9168105d-1b57-4863-8008-94e8c619ca45"],
        [azuread_group.ca021_exclusion.object_id]
      )
    }

    devices {
      filter {
        mode = "exclude"
        rule = "device.deviceOwnership -eq \"Company\" -or device.isCompliant -eq True"
      }
    }
  }

  session_controls {
    persistent_browser_mode = "never"
  }
}
