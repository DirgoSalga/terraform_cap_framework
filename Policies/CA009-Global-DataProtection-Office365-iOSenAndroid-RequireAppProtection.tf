# locals {
#   ca009 = "CA009-Global-DataProtection-Office365-iOSenAndroid-RequireAppProtection"
# }

# resource "azuread_group" "ca009_exclusion" {
#   display_name     = "${local.ca009}-Exclusion"
#   security_enabled = true
# }

# resource "azuread_conditional_access_policy" "ca009" {
#   display_name = local.ca009
#   state        = "enabledForReportingButNotEnforced"

#   conditions {
#     client_app_types = ["all"]

#     applications {
#       included_applications = ["00000002-0000-0ff1-ce00-000000000000", "00000003-0000-0ff1-ce00-000000000000"]
#     }

#     users {
#       included_users = ["All"]
#       excluded_roles = ["9b895d92-2cd3-44c7-9d02-a6ac2d5ea5c3", "c4e39bd9-1100-46d3-8c65-fb160da0071f", "b0f54661-2d74-4c50-afa3-1ec803f12efe", "158c047a-c907-4556-b7ef-446551a6b5f7", "b1be1c3e-b65d-4f19-8427-f6fa0d97feb9", "29232cdf-9323-42fd-ade2-1d097af3e4de", "62e90394-69f5-4237-9190-012177145e10", "729827e3-9c14-49f7-bb1b-9608f156bbb8", "966707d0-3269-4727-9be2-8c3a10f19b9d", "e8611ab8-c189-46e8-94e1-60213ab1f814", "7be44c8a-adaf-4e2a-84d6-ab2649e08a13", "194ae4cb-b126-40b2-bd5b-6091b380977d", "f28a1f50-f6e7-4571-818b-6a12f2af6b6c", "fe930be7-5e62-47db-91af-98c3a49a38b1", "f2ef992c-3afb-46b9-b7cf-a126ee74c451", "3a2c62db-5318-420d-8d74-23affee5d9d5"]
#       excluded_groups = [
#         var.breakglass_group_object_id,
#         azuread_group.ca009_exclusion.object_id
#       ]
#     }

#     platforms {
#       included_platforms = ["android", "iOS"]
#     }
#   }

#   grant_controls {
#     operator          = "OR"
#     built_in_controls = ["compliantApplication"]
#   }
# }
