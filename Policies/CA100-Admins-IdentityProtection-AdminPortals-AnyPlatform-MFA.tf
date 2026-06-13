locals {
  ca100 = "CA100-Admins-IdentityProtection-AdminPortals-AnyPlatform-MFA"
}

resource "azuread_group" "ca100_exclusion" {
  display_name     = "${local.ca100}-Exclusion"
  security_enabled = true
}

resource "azuread_conditional_access_policy" "ca100" {
  display_name = local.ca100
  state        = "enabledForReportingButNotEnforced"

  conditions {
    client_app_types = ["all"]

    applications {
      included_applications = ["MicrosoftAdminPortals"]
    }

    users {
      included_roles = ["62e90394-69f5-4237-9190-012177145e10", "194ae4cb-b126-40b2-bd5b-6091b380977d", "f28a1f50-f6e7-4571-818b-6a12f2af6b6c", "29232cdf-9323-42fd-ade2-1d097af3e4de", "b1be1c3e-b65d-4f19-8427-f6fa0d97feb9", "729827e3-9c14-49f7-bb1b-9608f156bbb8", "b0f54661-2d74-4c50-afa3-1ec803f12efe", "fe930be7-5e62-47db-91af-98c3a49a38b1", "c4e39bd9-1100-46d3-8c65-fb160da0071f", "9b895d92-2cd3-44c7-9d02-a6ac2d5ea5c3", "158c047a-c907-4556-b7ef-446551a6b5f7", "966707d0-3269-4727-9be2-8c3a10f19b9d", "7be44c8a-adaf-4e2a-84d6-ab2649e08a13", "e8611ab8-c189-46e8-94e1-60213ab1f814", "f2ef992c-3afb-46b9-b7cf-a126ee74c451", "3a2c62db-5318-420d-8d74-23affee5d9d5", "d2562ede-74db-457e-a7b6-544e236ebb61", "db506228-d27e-4b7d-95e5-295956d6615f", "6b942400-691f-4bf0-9d12-d8a254a2baf5", "e93e3737-fa85-474a-aee4-7d3fb86510f3", "b6a27b2b-f905-4b2e-81b5-0d90e0ef1fdb", "1707125e-0aa2-4d4d-8655-a7c786c76a25", "69091246-20e8-4a56-aa4d-066075b2a7a8", "11451d60-acb2-45eb-a7d6-43d0f0125c13"]
      excluded_groups = concat(
        ["2802b872-ccfb-4b29-a9a9-459808dfb11b", "70899f87-a5ba-4145-8bd5-2230db5dbbff"],
        [azuread_group.ca100_exclusion.object_id]
      )
    }
  }

  grant_controls {
    operator = "OR"
    authentication_strength_policy_id = "/policies/authenticationStrengthPolicies/00000000-0000-0000-0000-000000000002"
  }
}
