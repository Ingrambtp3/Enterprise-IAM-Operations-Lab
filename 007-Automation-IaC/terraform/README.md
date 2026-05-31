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

## Screenshots 
<img width="1240" height="98" alt="Screenshot 2026-05-30 at 7 32 58 PM" src="https://github.com/user-attachments/assets/78270079-f124-40ae-8547-3c22e5f97509" />
<img width="569" height="65" alt="Screenshot 2026-05-30 at 7 47 57 PM" src="https://github.com/user-attachments/assets/e5d5d6f1-52c9-4bde-b633-92f2567646d7" />
<img width="609" height="52" alt="Screenshot 2026-05-30 at 7 48 10 PM" src="https://github.com/user-attachments/assets/49a8acad-c34a-4483-9f1d-1b899fabf5a8" />
<img width="599" height="35" alt="Screenshot 2026-05-30 at 7 48 21 PM" src="https://github.com/user-attachments/assets/03de28a8-be1d-49b9-805b-23c8ca59ed1c" />
<img width="524" height="38" alt="Screenshot 2026-05-30 at 7 48 27 PM" src="https://github.com/user-attachments/assets/9d5b19e9-5a2d-4bc8-b09e-41ab7fe2357d" />
<img width="558" height="43" alt="Screenshot 2026-05-30 at 7 48 55 PM" src="https://github.com/user-attachments/assets/08480c34-82e5-4e67-b7f0-2925d6539713" />
