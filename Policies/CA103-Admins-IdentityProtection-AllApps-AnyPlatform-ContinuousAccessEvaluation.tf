# I have not been able to find a way to activate CAE using Terraform.

# locals {
#   ca103 = "CA103-Admins-IdentityProtection-AllApps-AnyPlatform-ContinuousAccessEvaluation"
# }

# resource "azuread_group" "ca103_exclusion" {
#   display_name     = "${local.ca103}-Exclusion"
#   security_enabled = true
# }

# resource "azuread_conditional_access_policy" "ca103" {
#   display_name = local.ca103
#   state        = "enabledForReportingButNotEnforced"

#   conditions {
#     client_app_types = ["all"]

#     applications {
#       included_applications = ["None"]
#     }

#     users {
#       included_groups = [azuread_group.admin_persona.object_id]
#       # included_roles = [
#       #   "9b895d92-2cd3-44c7-9d02-a6ac2d5ea5c3", # Application Administrator
#       #   "c4e39bd9-1100-46d3-8c65-fb160da0071f", # Authentication Administrator
#       #   "b0f54661-2d74-4c50-afa3-1ec803f12efe", # Billing Administrator
#       #   "158c047a-c907-4556-b7ef-446551a6b5f7", # Cloud Application Administrator
#       #   "b1be1c3e-b65d-4f19-8427-f6fa0d97feb9", # Conditional Access Administrator
#       #   "29232cdf-9323-42fd-ade2-1d097af3e4de", # Exchange Administrator
#       #   "62e90394-69f5-4237-9190-012177145e10", # Global Administrator
#       #   "f2ef992c-3afb-46b9-b7cf-a126ee74c451", # License Administrator
#       #   "729827e3-9c14-49f7-bb1b-9608f156bbb8", # Helpdesk Administrator
#       #   "3a2c62db-5318-420d-8d74-23affee5d9d5", # Intune Administrator
#       #   "966707d0-3269-4727-9be2-8c3a10f19b9d", # Password Administrator
#       #   "7be44c8a-adaf-4e2a-84d6-ab2649e08a13", # Privileged Authentication Administrator
#       #   "e8611ab8-c189-46e8-94e1-60213ab1f814", # Privileged Role Administrator
#       #   "194ae4cb-b126-40b2-bd5b-6091b380977d", # Security Administrator
#       #   "f28a1f50-f6e7-4571-818b-6a12f2af6b6c", # SharePoint Administrator
#       #   "fe930be7-5e62-47db-91af-98c3a49a38b1", # User Administrator
#       #   "db506228-d27e-4b7d-95e5-295956d6615f", # Agent ID Administrator
#       #   "6b942400-691f-4bf0-9d12-d8a254a2baf5", # Agent Registry Administrator
#       #   "d2562ede-74db-457e-a7b6-544e236ebb61", # AI Administrator
#       #   "e93e3737-fa85-474a-aee4-7d3fb86510f3", # Dragon Administrator
#       #   "b6a27b2b-f905-4b2e-81b5-0d90e0ef1fdb", # Entra Backup Administrator
#       #   "69091246-20e8-4a56-aa4d-066075b2a7a8", # Teams Administrator
#       #   "11451d60-acb2-45eb-a7d6-43d0f0125c13", # Windows 365 Administrator
#       #   "1707125e-0aa2-4d4d-8655-a7c786c76a25"  # Microsoft 365 Backup Administrator
#       # ]
#       excluded_groups = [
#         azuread_group.breakglass.object_id,
#         azuread_group.ca103_exclusion.object_id
#       ]
#     }
#   }
# }
