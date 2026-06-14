output "conditional_access_policies" {
  description = "Conditional Access policies created by this module, keyed by policy code."
  value = {
    ca000 = {
      display_name = azuread_conditional_access_policy.ca000.display_name
      id           = azuread_conditional_access_policy.ca000.id
      state        = azuread_conditional_access_policy.ca000.state
    }
    ca001 = {
      display_name = azuread_conditional_access_policy.ca001.display_name
      id           = azuread_conditional_access_policy.ca001.id
      state        = azuread_conditional_access_policy.ca001.state
    }
    ca002 = {
      display_name = azuread_conditional_access_policy.ca002.display_name
      id           = azuread_conditional_access_policy.ca002.id
      state        = azuread_conditional_access_policy.ca002.state
    }
    ca003 = {
      display_name = azuread_conditional_access_policy.ca003.display_name
      id           = azuread_conditional_access_policy.ca003.id
      state        = azuread_conditional_access_policy.ca003.state
    }
    ca004 = {
      display_name = azuread_conditional_access_policy.ca004.display_name
      id           = azuread_conditional_access_policy.ca004.id
      state        = azuread_conditional_access_policy.ca004.state
    }
    ca005 = {
      display_name = azuread_conditional_access_policy.ca005.display_name
      id           = azuread_conditional_access_policy.ca005.id
      state        = azuread_conditional_access_policy.ca005.state
    }
    ca100 = {
      display_name = azuread_conditional_access_policy.ca100.display_name
      id           = azuread_conditional_access_policy.ca100.id
      state        = azuread_conditional_access_policy.ca100.state
    }
    ca101 = {
      display_name = azuread_conditional_access_policy.ca101.display_name
      id           = azuread_conditional_access_policy.ca101.id
      state        = azuread_conditional_access_policy.ca101.state
    }
    ca102 = {
      display_name = azuread_conditional_access_policy.ca102.display_name
      id           = azuread_conditional_access_policy.ca102.id
      state        = azuread_conditional_access_policy.ca102.state
    }
    ca200 = {
      display_name = azuread_conditional_access_policy.ca200.display_name
      id           = azuread_conditional_access_policy.ca200.id
      state        = azuread_conditional_access_policy.ca200.state
    }
    ca201 = {
      display_name = azuread_conditional_access_policy.ca201.display_name
      id           = azuread_conditional_access_policy.ca201.id
      state        = azuread_conditional_access_policy.ca201.state
    }
    ca202 = {
      display_name = azuread_conditional_access_policy.ca202.display_name
      id           = azuread_conditional_access_policy.ca202.id
      state        = azuread_conditional_access_policy.ca202.state
    }
    ca203 = {
      display_name = azuread_conditional_access_policy.ca203.display_name
      id           = azuread_conditional_access_policy.ca203.id
      state        = azuread_conditional_access_policy.ca203.state
    }
    ca204 = {
      display_name = azuread_conditional_access_policy.ca204.display_name
      id           = azuread_conditional_access_policy.ca204.id
      state        = azuread_conditional_access_policy.ca204.state
    }
    ca205 = {
      display_name = azuread_conditional_access_policy.ca205.display_name
      id           = azuread_conditional_access_policy.ca205.id
      state        = azuread_conditional_access_policy.ca205.state
    }
    ca206 = {
      display_name = azuread_conditional_access_policy.ca206.display_name
      id           = azuread_conditional_access_policy.ca206.id
      state        = azuread_conditional_access_policy.ca206.state
    }
    ca207 = {
      display_name = azuread_conditional_access_policy.ca207.display_name
      id           = azuread_conditional_access_policy.ca207.id
      state        = azuread_conditional_access_policy.ca207.state
    }
    ca208 = {
      display_name = azuread_conditional_access_policy.ca208.display_name
      id           = azuread_conditional_access_policy.ca208.id
      state        = azuread_conditional_access_policy.ca208.state
    }
    ca300 = {
      display_name = azuread_conditional_access_policy.ca300.display_name
      id           = azuread_conditional_access_policy.ca300.id
      state        = azuread_conditional_access_policy.ca300.state
    }
    ca301 = {
      display_name = azuread_conditional_access_policy.ca301.display_name
      id           = azuread_conditional_access_policy.ca301.id
      state        = azuread_conditional_access_policy.ca301.state
    }
    ca400 = {
      display_name = azuread_conditional_access_policy.ca400.display_name
      id           = azuread_conditional_access_policy.ca400.id
      state        = azuread_conditional_access_policy.ca400.state
    }
    ca401 = {
      display_name = azuread_conditional_access_policy.ca401.display_name
      id           = azuread_conditional_access_policy.ca401.id
      state        = azuread_conditional_access_policy.ca401.state
    }
    ca402 = {
      display_name = azuread_conditional_access_policy.ca402.display_name
      id           = azuread_conditional_access_policy.ca402.id
      state        = azuread_conditional_access_policy.ca402.state
    }
    ca403 = {
      display_name = azuread_conditional_access_policy.ca403.display_name
      id           = azuread_conditional_access_policy.ca403.id
      state        = azuread_conditional_access_policy.ca403.state
    }
  }
}

output "conditional_access_exclusion_groups" {
  description = "Per-policy exclusion groups created by this module, keyed by policy code."
  value = {
    ca000 = {
      display_name = azuread_group.ca000_exclusion.display_name
      object_id    = azuread_group.ca000_exclusion.object_id
    }
    ca001 = {
      display_name = azuread_group.ca001_exclusion.display_name
      object_id    = azuread_group.ca001_exclusion.object_id
    }
    ca002 = {
      display_name = azuread_group.ca002_exclusion.display_name
      object_id    = azuread_group.ca002_exclusion.object_id
    }
    ca003 = {
      display_name = azuread_group.ca003_exclusion.display_name
      object_id    = azuread_group.ca003_exclusion.object_id
    }
    ca004 = {
      display_name = azuread_group.ca004_exclusion.display_name
      object_id    = azuread_group.ca004_exclusion.object_id
    }
    ca005 = {
      display_name = azuread_group.ca005_exclusion.display_name
      object_id    = azuread_group.ca005_exclusion.object_id
    }
    ca100 = {
      display_name = azuread_group.ca100_exclusion.display_name
      object_id    = azuread_group.ca100_exclusion.object_id
    }
    ca101 = {
      display_name = azuread_group.ca101_exclusion.display_name
      object_id    = azuread_group.ca101_exclusion.object_id
    }
    ca102 = {
      display_name = azuread_group.ca102_exclusion.display_name
      object_id    = azuread_group.ca102_exclusion.object_id
    }
    ca200 = {
      display_name = azuread_group.ca200_exclusion.display_name
      object_id    = azuread_group.ca200_exclusion.object_id
    }
    ca201 = {
      display_name = azuread_group.ca201_exclusion.display_name
      object_id    = azuread_group.ca201_exclusion.object_id
    }
    ca202 = {
      display_name = azuread_group.ca202_exclusion.display_name
      object_id    = azuread_group.ca202_exclusion.object_id
    }
    ca203 = {
      display_name = azuread_group.ca203_exclusion.display_name
      object_id    = azuread_group.ca203_exclusion.object_id
    }
    ca204 = {
      display_name = azuread_group.ca204_exclusion.display_name
      object_id    = azuread_group.ca204_exclusion.object_id
    }
    ca205 = {
      display_name = azuread_group.ca205_exclusion.display_name
      object_id    = azuread_group.ca205_exclusion.object_id
    }
    ca206 = {
      display_name = azuread_group.ca206_exclusion.display_name
      object_id    = azuread_group.ca206_exclusion.object_id
    }
    ca207 = {
      display_name = azuread_group.ca207_exclusion.display_name
      object_id    = azuread_group.ca207_exclusion.object_id
    }
    ca208 = {
      display_name = azuread_group.ca208_exclusion.display_name
      object_id    = azuread_group.ca208_exclusion.object_id
    }
    ca300 = {
      display_name = azuread_group.ca300_exclusion.display_name
      object_id    = azuread_group.ca300_exclusion.object_id
    }
    ca301 = {
      display_name = azuread_group.ca301_exclusion.display_name
      object_id    = azuread_group.ca301_exclusion.object_id
    }
    ca400 = {
      display_name = azuread_group.ca400_exclusion.display_name
      object_id    = azuread_group.ca400_exclusion.object_id
    }
    ca401 = {
      display_name = azuread_group.ca401_exclusion.display_name
      object_id    = azuread_group.ca401_exclusion.object_id
    }
    ca402 = {
      display_name = azuread_group.ca402_exclusion.display_name
      object_id    = azuread_group.ca402_exclusion.object_id
    }
    ca403 = {
      display_name = azuread_group.ca403_exclusion.display_name
      object_id    = azuread_group.ca403_exclusion.object_id
    }
  }
}
