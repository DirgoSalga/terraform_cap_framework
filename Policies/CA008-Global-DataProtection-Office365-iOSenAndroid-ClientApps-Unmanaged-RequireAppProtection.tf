# locals {
#   ca008 = "CA008-Global-DataProtection-Office365-iOSenAndroid-ClientApps-Unmanaged-RequireAppProtection"
# }

# resource "azuread_group" "ca008_exclusion" {
#   display_name     = "${local.ca008}-Exclusion"
#   security_enabled = true
# }

# resource "azuread_conditional_access_policy" "ca008" {
#   display_name = local.ca008
#   state        = "enabledForReportingButNotEnforced"

#   conditions {
#     client_app_types = ["mobileAppsAndDesktopClients"]

#     applications {
#       included_applications = ["Office365"]
#     }

#     users {
#       included_users = ["All"]
#       excluded_groups = [
#         var.breakglass_group_object_id,
#         azuread_group.ca008_exclusion.object_id
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
