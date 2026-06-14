module "policies" {
  source = "./Policies"

  breakglass_group_object_id               = azuread_group.breakglass.object_id
  admin_persona_group_object_id            = azuread_group.admin_persona.object_id
  internals_persona_group_object_id        = azuread_group.internals_persona.object_id
  service_accounts_persona_group_object_id = azuread_group.service_accounts_persona.object_id
  eu_named_location_id                     = azuread_named_location.eu.id
  eu_named_location_object_id              = azuread_named_location.eu.object_id
}
