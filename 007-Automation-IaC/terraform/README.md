# Terraform — Entra ID Infrastructure as Code

**Phase:** 7 — Automation and IaC
**Tool:** Terraform v1.15.5 + AzureAD Provider v2.53.1
**Tenant:** ByteKage (ByteKage.onmicrosoft.com)
**Status:** ✅ Live — applied and verified
**Date:** 2026-05-30

---

## What This Does

This Terraform configuration provisions identity resources in the ByteKage
Entra ID tenant as code — users, groups, and group membership.

Instead of clicking through the portal, every resource is defined in a `.tf` file,
version controlled, and deployable in a single command.

---

## Resources Managed

| Resource | Type | Purpose |
|---|---|---|
| svc.graphapi@ByteKage.onmicrosoft.com | User | Graph API service account |
| ByteKage-ServiceAccounts | Security Group | Service and automation accounts |
| ByteKage-GuestUsers | Security Group | External guest identities |
| svc.graphapi → ByteKage-ServiceAccounts | Group Membership | Service account group assignment |

---

## Files

| File | Purpose |
|---|---|
| `main.tf` | Provider configuration and tenant ID |
| `resources.tf` | Resource definitions — users, groups, membership |
| `.terraform.lock.hcl` | Provider version lock file |

---

## How to Use

### Prerequisites
- Terraform installed (`brew install hashicorp/tap/terraform`)
- Azure CLI installed and authenticated (`az login`)

### Commands

```bash
# Initialize — downloads provider
terraform init

# Preview changes before applying
terraform plan

# Apply changes to tenant
terraform apply

# Destroy all managed resources
terraform destroy
```

---

## Why IaC for IAM

Manual portal configuration is not repeatable, not auditable at the code level,
and not scalable. Terraform solves all three:

- **Repeatable** — run `terraform apply` in any tenant and get the same result
- **Auditable** — every change is a git commit with a diff
- **Scalable** — adding 10 more groups is 10 more lines of code, not 10 portal sessions

This is how enterprise IAM teams manage identity infrastructure at scale.