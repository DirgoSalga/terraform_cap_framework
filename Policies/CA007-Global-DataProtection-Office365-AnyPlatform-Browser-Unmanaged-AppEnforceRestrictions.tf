# locals {
#   ca007 = "CA007-Global-DataProtection-Office365-AnyPlatform-Browser-Unmanaged-AppEnforceRestrictions"
# }

# resource "azuread_group" "ca007_exclusion" {
#   display_name     = "${local.ca007}-Exclusion"
#   security_enabled = true
# }

# resource "azuread_conditional_access_policy" "ca007" {
#   display_name = local.ca007
#   state        = "enabledForReportingButNotEnforced"

#   conditions {
#     client_app_types = ["browser"]

#     applications {
#       included_applications = ["00000003-0000-0ff1-ce00-000000000000", "00000002-0000-0ff1-ce00-000000000000"]
#     }

#     users {
#       included_users = ["All"]
#       excluded_groups = [
#         var.breakglass_group_object_id,
#         azuread_group.ca007_exclusion.object_id
#       ]
#     }

#     devices {
#       filter {
#         mode = "exclude"
#         rule = "device.isCompliant -eq True -and device.deviceOwnership -eq \"Company\""
#       }
#     }
#   }

#   session_controls {
#     application_enforced_restrictions_enabled = true
#   }
# }
