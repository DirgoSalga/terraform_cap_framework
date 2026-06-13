locals {
  ca011 = "CA102-Admins-IdentityProtection-AllApps-AnyPlatform-SigninFrequency"
}

resource "azuread_group" "ca011_exclusion" {
  display_name     = "${local.ca011}-Exclusion"
  security_enabled = true
}

resource "azuread_conditional_access_policy" "ca011" {
  display_name = local.ca011
  state        = "enabledForReportingButNotEnforced"

  conditions {
    client_app_types = ["all"]

    applications {
      included_applications = ["All"]
    }

    users {
      included_roles = ["c4e39bd9-1100-46d3-8c65-fb160da0071f", "b0f54661-2d74-4c50-afa3-1ec803f12efe", "b1be1c3e-b65d-4f19-8427-f6fa0d97feb9", "29232cdf-9323-42fd-ade2-1d097af3e4de", "62e90394-69f5-4237-9190-012177145e10", "f2ef992c-3afb-46b9-b7cf-a126ee74c451", "729827e3-9c14-49f7-bb1b-9608f156bbb8", "3a2c62db-5318-420d-8d74-23affee5d9d5", "194ae4cb-b126-40b2-bd5b-6091b380977d", "fe930be7-5e62-47db-91af-98c3a49a38b1", "f28a1f50-f6e7-4571-818b-6a12f2af6b6c", "db506228-d27e-4b7d-95e5-295956d6615f", "6b942400-691f-4bf0-9d12-d8a254a2baf5", "d2562ede-74db-457e-a7b6-544e236ebb61", "9b895d92-2cd3-44c7-9d02-a6ac2d5ea5c3", "b6a27b2b-f905-4b2e-81b5-0d90e0ef1fdb", "1707125e-0aa2-4d4d-8655-a7c786c76a25", "966707d0-3269-4727-9be2-8c3a10f19b9d", "69091246-20e8-4a56-aa4d-066075b2a7a8", "11451d60-acb2-45eb-a7d6-43d0f0125c13", "158c047a-c907-4556-b7ef-446551a6b5f7", "7be44c8a-adaf-4e2a-84d6-ab2649e08a13", "e8611ab8-c189-46e8-94e1-60213ab1f814", "e93e3737-fa85-474a-aee4-7d3fb86510f3"]
      excluded_groups = concat(
        ["2802b872-ccfb-4b29-a9a9-459808dfb11b", "5dcf5173-9efb-4f3f-a19d-2f03760d4e1d"],
        [azuread_group.ca011_exclusion.object_id]
      )
    }
  }

  session_controls {
    sign_in_frequency = 12
    sign_in_frequency_period = "hours"
    sign_in_frequency_authentication_type = "primaryAndSecondaryAuthentication"
    sign_in_frequency_interval = "timeBased"
  }
}
