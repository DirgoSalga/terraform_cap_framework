locals {
  ca005 = "CA005-Global-DataProtection-Office365-AnyPlatform-Unmanaged-RequireAppProtection"
}

resource "azuread_group" "ca005_exclusion" {
  display_name     = "${local.ca005}-Exclusion"
  security_enabled = true
}

resource "azuread_conditional_access_policy" "ca005" {
  display_name = local.ca005
  state        = "enabledForReportingButNotEnforced"

  conditions {
    client_app_types = ["browser", "mobileAppsAndDesktopClients"]

    applications {
      included_applications = ["Office365"]
    }

    users {
      included_users = ["All"]
      excluded_groups = concat(
        ["2802b872-ccfb-4b29-a9a9-459808dfb11b", "20cd89e3-25e2-4fcd-82c5-de666dfd31a4"],
        [azuread_group.ca005_exclusion.object_id]
      )
    }

    platforms {
      included_platforms = ["android", "iOS"]
    }

    devices {
      filter {
        mode = "exclude"
        rule = "device.isCompliant -eq True -and device.deviceOwnership -eq \"Company\""
      }
    }
  }

  grant_controls {
    operator = "OR"
    built_in_controls = ["compliantApplication"]
  }

  session_controls {
    application_enforced_restrictions_enabled = true
  }
}
