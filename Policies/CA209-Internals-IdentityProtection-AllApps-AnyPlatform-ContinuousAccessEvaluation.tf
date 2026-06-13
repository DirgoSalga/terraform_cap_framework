# I have not been able to find a way to activate CAE using Terraform.
# locals {
#   ca209 = "CA209-Internals-IdentityProtection-AllApps-AnyPlatform-ContinuousAccessEvaluation"
# }
#
# resource "azuread_group" "ca209_exclusion" {
#   display_name     = "${local.ca209}-Exclusion"
#   security_enabled = true
# }
#
# resource "azuread_conditional_access_policy" "ca209" {
#   display_name = local.ca209
#   state        = "enabledForReportingButNotEnforced"
#
#   conditions {
#     client_app_types = ["all"]
#
#     applications {
#       included_applications = ["All"]
#     }
#
#     users {
#       included_groups = [azuread_group.internals_persona.object_id]
#       excluded_groups = [
#         azuread_group.breakglass.object_id,
#         azuread_group.ca209_exclusion.object_id
#       ]
#     }
#   }
# }
