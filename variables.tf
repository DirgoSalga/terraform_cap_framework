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