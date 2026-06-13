locals {
  ca207 = "CA207-Internals-AttackSurfaceReduction-SelectedApps-AnyPlatform-BLOCK"
}

resource "azuread_group" "ca207_exclusion" {
  display_name     = "${local.ca207}-Exclusion"
  security_enabled = true
}

resource "azuread_conditional_access_policy" "ca207" {
  display_name = local.ca207
  state        = "enabledForReportingButNotEnforced"

  conditions {
    client_app_types = ["browser", "mobileAppsAndDesktopClients"]

    applications {
      included_applications = ["ac460cad-155d-4280-956e-1a0b8c167249"] # example: Canva. Add specific application IDs to include in the policy from your tenant
      excluded_applications = ["Office365"]
    }

    users {
      included_groups = [azuread_group.internals_persona.object_id]
      excluded_groups = [
        azuread_group.breakglass.object_id,
        azuread_group.ca207_exclusion.object_id
      ]
    }
  }

  grant_controls {
    operator          = "OR"
    built_in_controls = ["block"]
  }
}
