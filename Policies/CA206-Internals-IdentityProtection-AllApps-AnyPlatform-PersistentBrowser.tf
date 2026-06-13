locals {
  ca206 = "CA206-Internals-IdentityProtection-AllApps-AnyPlatform-PersistentBrowser"
}

resource "azuread_group" "ca206_exclusion" {
  display_name     = "${local.ca206}-Exclusion"
  security_enabled = true
}

resource "azuread_conditional_access_policy" "ca206" {
  display_name = local.ca206
  state        = "enabledForReportingButNotEnforced"

  conditions {
    client_app_types = ["browser"]

    applications {
      included_applications = ["All"]
    }

    users {
      included_groups = [azuread_group.internals_persona.object_id]
      excluded_groups = [
        azuread_group.breakglass.object_id,
        azuread_group.ca206_exclusion.object_id
      ]
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
