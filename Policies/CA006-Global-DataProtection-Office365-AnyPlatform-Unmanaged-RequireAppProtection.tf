# locals {
#   ca006 = "CA006-Global-DataProtection-Office365-AnyPlatform-Unmanaged-RequireAppProtection"
# }

# resource "azuread_group" "ca006_exclusion" {
#   display_name     = "${local.ca006}-Exclusion"
#   security_enabled = true
# }

# resource "azuread_conditional_access_policy" "ca006" {
#   display_name = local.ca006
#   state        = "enabledForReportingButNotEnforced"

#   conditions {
#     client_app_types = ["browser", "mobileAppsAndDesktopClients"]

#     applications {
#       included_applications = ["Office365"]
#     }

#     users {
#       included_users = ["All"]
#       excluded_groups = [
#         azuread_group.breakglass.object_id,
#         azuread_group.ca006_exclusion.object_id
#       ]
#     }

#     platforms {
#       included_platforms = ["android", "iOS"]
#     }

#     devices {
#       filter {
#         mode = "exclude"
#         rule = "device.isCompliant -eq True -and device.deviceOwnership -eq \"Company\""
#       }
#     }
#   }

#   grant_controls {
#     operator          = "OR"
#     built_in_controls = ["compliantApplication"]
#   }

#   session_controls {
#     application_enforced_restrictions_enabled = true
#   }
# }
