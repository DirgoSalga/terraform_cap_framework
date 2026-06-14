# Terraform Conditional Access Framework

Terraform configuration for managing Microsoft Entra Conditional Access policy baselines with the `hashicorp/azuread` provider.

These policies are heavily inspired by Joey Verlinden's Conditional Access baseline: <https://github.com/j0eyv/ConditionalAccessBaseline>.

The repository is organized around policy families:

- `CA000` series: global baseline protections
- `CA100` series: admin persona protections
- `CA200` series: internal user protections
- `CA300` series: service account protections
- `CA400` series: guest user protections

Most policy resources are currently configured with:

```hcl
state = "enabledForReportingButNotEnforced"
```

Review sign-in impact before changing policies to enforced mode.

## Requirements

- Terraform `>= 1.15.0`
- AzureAD provider `~> 3.8`
- Microsoft Entra ID tenant with the licensing required for Conditional Access
- Permissions to create users, groups, named locations, and Conditional Access policies

The AzureAD provider can authenticate using any supported provider method, including Azure CLI, service principal credentials, managed identity, or environment variables.

## Repository Layout

```text
.
├── main.tf                # Calls the Policies child module
├── breakglass.tf          # Emergency access users and exclusion group
├── named_locations.tf     # Named locations used by location-based policies
├── persona_groups.tf      # Persona groups used by policy assignments
├── providers.tf           # AzureAD provider configuration
├── terraform.tfvars.example # Example variable values
├── variables.tf           # Configurable names, UPNs, rules, and membership
├── versions.tf            # Terraform and provider version constraints
├── conversion_warnings.md # Notes for settings not represented in Terraform
└── Policies/              # Conditional Access policy resources
```

Some policy files are fully commented placeholders. They are retained to preserve the policy sequence and document configurations that are not currently active or not represented by the AzureAD provider.

## Personas

The framework uses persona groups to avoid hard-coded assignment IDs in Conditional Access policies.

| Persona | Resource | Membership type | Default |
| --- | --- | --- | --- |
| Admins | `azuread_group.admin_persona` | Dynamic | UPN starts with `adm.` and ends with `.onmicrosoft.com` |
| Internals | `azuread_group.internals_persona` | Dynamic | `user.companyName -eq "DirgoSalga"` |
| Service Accounts | `azuread_group.service_accounts_persona` | Assigned | Empty member set by default |

Configure these in `variables.tf` or a local `*.tfvars` file.

## Break-Glass Accounts

`breakglass.tf` creates two emergency access users and a role-assignable emergency access exclusion group. The group is excluded from Conditional Access policies.

The default passwords in `breakglass.tf` are placeholders. Replace or rotate them before using this against a real tenant, and store operational credentials in a vault.

## Variables

Common variables include:

- `breakglass_upn_1`
- `breakglass_upn_2`
- `breakglass_group_name`
- `admin_persona_group_name`
- `admin_persona_dynamic_membership_rule`
- `internals_persona_group_name`
- `internals_persona_dynamic_membership_rule`
- `service_accounts_persona_group_name`
- `service_accounts_persona_member_object_ids`

See `terraform.tfvars.example` for a complete starting point. Example `terraform.tfvars`:

```hcl
breakglass_upn_1 = "btg.1@example.com"
breakglass_upn_2 = "btg.2@example.com"

admin_persona_group_name     = "CA-Persona-Admins"
internals_persona_group_name = "CA-Persona-Internals"

service_accounts_persona_member_object_ids = [
  "00000000-0000-0000-0000-000000000000",
]
```

Do not commit tenant-specific secrets or sensitive operational credentials.

## Workflow

Initialize providers:

```sh
terraform init
```

Format and validate:

```sh
terraform fmt -recursive
terraform validate
```

Review planned changes:

```sh
terraform plan
```

Apply after review:

```sh
terraform apply
```

Review deployment outputs:

```sh
terraform output
terraform output conditional_access_policies
terraform output conditional_access_exclusion_groups
```

The outputs include policy IDs, exclusion group object IDs, persona groups, named locations, and emergency access account UPNs. Passwords are intentionally not output.

## Policy Notes

- Policy naming follows the `CA###-Persona-Control-Apps-Platform-Outcome` convention.
- Every active policy should exclude the break-glass group and its own policy-specific exclusion group.
- Global and persona policies are kept as separate files to make reviews and staged rollouts easier.
- `conversion_warnings.md` tracks Conditional Access settings that were not represented by the current AzureAD provider, such as Continuous Access Evaluation session controls.

## Operational Guidance

- Keep policies in report-only mode until sign-in logs confirm expected behavior.
- Use Microsoft Entra's What If tool and sign-in logs to test each policy.
- Be careful with `block` controls scoped to all resources.
- Changes to Terraform resource names can require `moved` blocks or `terraform state mv` if resources already exist in state.

## License

See `LICENSE`.
