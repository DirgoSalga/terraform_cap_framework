variable "breakglass_upn_1" {
  description = "User principal name for the first emergency access account."
  type        = string
  default     = "btg.1@dirgosalga.com"
}

variable "breakglass_upn_2" {
  description = "User principal name for the second emergency access account."
  type        = string
  default     = "btg.2@dirgosalga.com"
}

variable "breakglass_group_name" {
  description = "Display name for the emergency access exclusion group."
  type        = string
  default     = "CA-Emergency-Access-Exclusion"
}

variable "admin_persona_group_name" {
  description = "Display name for the dynamic admin persona group."
  type        = string
  default     = "CA-Persona-Admins"
}

variable "admin_persona_dynamic_membership_rule" {
  description = "Dynamic membership rule for the admin persona group."
  type        = string
  default     = "(user.userPrincipalName -startsWith \"adm.\") -and (user.userPrincipalName -endsWith \".onmicrosoft.com\")"
}

variable "internals_persona_group_name" {
  description = "Display name for the dynamic internals persona group."
  type        = string
  default     = "CA-Persona-Internals"
}

variable "internals_persona_dynamic_membership_rule" {
  description = "Dynamic membership rule for the internals persona group."
  type        = string
  default     = "(user.companyName -eq \"DirgoSalga\")"
}

variable "service_accounts_persona_group_name" {
  description = "Display name for the assigned service accounts persona group."
  type        = string
  default     = "CA-Persona-ServiceAccounts"
}

variable "service_accounts_persona_member_object_ids" {
  description = "Object IDs for members of the service accounts persona group."
  type        = set(string)
  default     = []
}
