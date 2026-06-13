locals {
  ca018 = "CA203-Internals-AppProtection-MicrosoftIntuneEnrollment-AnyPlatform-MFA"
}

resource "azuread_group" "ca018_exclusion" {
  display_name     = "${local.ca018}-Exclusion"
  security_enabled = true
}

resource "azuread_conditional_access_policy" "ca018" {
  display_name = local.ca018
  state        = "enabledForReportingButNotEnforced"

  conditions {
    client_app_types = ["all"]

    applications {
      included_applications = ["d4ebce55-015a-49b5-a083-c84d1797ae8c"]
    }

    users {
      included_groups = ["ceeac9b8-ddf5-48cb-afcb-e2ab8bfd1a57"]
      excluded_groups = concat(
        ["2802b872-ccfb-4b29-a9a9-459808dfb11b", "2eee133e-3427-4860-81b9-057d5b28b022"],
        [azuread_group.ca018_exclusion.object_id]
      )
    }
  }

  grant_controls {
    operator = "OR"
    built_in_controls = ["mfa"]
  }

  session_controls {
    sign_in_frequency_authentication_type = "primaryAndSecondaryAuthentication"
    sign_in_frequency_interval = "everyTime"
  }
}
