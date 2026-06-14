variable "breakglass_group_object_id" {
  description = "Object ID of the emergency access exclusion group."
  type        = string
}

variable "admin_persona_group_object_id" {
  description = "Object ID of the admin persona group."
  type        = string
}

variable "internals_persona_group_object_id" {
  description = "Object ID of the internals persona group."
  type        = string
}

variable "service_accounts_persona_group_object_id" {
  description = "Object ID of the service accounts persona group."
  type        = string
}

variable "eu_named_location_id" {
  description = "Terraform ID of the European Union named location."
  type        = string
}

variable "eu_named_location_object_id" {
  description = "Object ID of the European Union named location."
  type        = string
}
