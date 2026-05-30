# 001 — Foundation🛡️

**Phase:** 1 — Foundation
**Tenant:** ByteKage (ByteKage.onmicrosoft.com)
**Status:** ✅ Complete
**Date:** 2026-05-30

---

## What This Covers🕵🏾

- Tenant configuration and baseline settings
- User account structure (naming conventions, UPN format)
- Group architecture (security groups, naming standards, nesting policy)
- Break-glass emergency access account
- Baseline admin account structure

## Design Decisions🧠

All configuration choices in this phase are documented with the reasoning behind them —
not just what was set, but why, and what risk it addresses or tradeoff it accepts.

---

## Naming Convention📋

User accounts follow the format: `role.name@ByteKage.onmicrosoft.com`

| Prefix | Account Type | Example |
|---|---|---|
| `adm.` | Admin account | adm.ingram@ByteKage.onmicrosoft.com |
| `usr.` | Standard user | usr.testuser@ByteKage.onmicrosoft.com |
| `svc.` | Service account | svc.graphapi@ByteKage.onmicrosoft.com |
| `breakglass` | Emergency access | breakglass@ByteKage.onmicrosoft.com |

This mirrors enterprise naming patterns and makes account type immediately identifiable
from the UPN prefix — reducing ambiguity during access reviews and incident response.

---

## User Accounts Created🛠️

| Display Name | UPN | Purpose | Created |
|---|---|---|---|
| Allon Ingram (Admin) | adm.ingram@ByteKage.onmicrosoft.com | Primary admin persona | 2026-05-30 |
| Test Admin User | adm.testuser@ByteKage.onmicrosoft.com | Test persona for JIT activation and lifecycle simulation | 2026-05-30 |
| Break Glass Emergency Access | breakglass@ByteKage.onmicrosoft.com | Emergency global admin — break-glass account | 2026-05-30 |

---

## Groups Created🤝

| Group Name | Type | Membership Type | Members | Purpose |
|---|---|---|---|---|
| ByteKage-Admins | Security | Assigned | adm.ingram, adm.testuser | Privileged role holders |
| ByteKage-Consultants | Security | Assigned | (empty — Phase 3) | External/client-facing identities |
| ByteKage-Clients | Security | Assigned | (empty — Phase 3) | Client tenant simulation |
| ByteKage-Contractors | Security | Assigned | (empty — Phase 3) | Non-employee lifecycle testing |

---

## Break-Glass Account⚒️

A break-glass (emergency access) account is configured with Global Administrator
and exists outside all normal access controls.

| Setting | Value | Rationale |
|---|---|---|
| UPN | breakglass@ByteKage.onmicrosoft.com | Named to be obviously a break-glass account |
| Role | Global Administrator | Must be able to recover the tenant under any failure condition |
| CA exclusion | Excluded from all policies | Cannot be blocked by a misconfigured CA policy |
| Password storage | Offline only | Never stored digitally in the same environment it protects |
| Monitoring | Sign-in alerts enabled | Any use of this account triggers immediate review |

**Risk:** If compromised, this account bypasses nearly all controls.
**Mitigation:** Exclusion from CA is documented and reviewed quarterly. Any sign-in fires an alert.

---

## What This Enables📌

- Phase 2 (Access Control) — group structure is the target for Conditional Access policies
- Phase 3 (Governance) — ByteKage-Admins group feeds PIM eligible role assignments
- Phase 4 (Operations) — break-glass account use is a monitored event with runbook response

---

## Status✨

✅ Complete — Users created, groups created, ByteKage-Admins populated, break-glass account active with Global Administrator assigned.

## Screenshots 📸
<img width="1524" height="686" alt="Screenshot 2026-05-30 at 5 39 17 PM" src="https://github.com/user-attachments/assets/c9da6be2-7f06-4ef4-bf31-33c58e5514eb" />
<img width="1289" height="455" alt="Screenshot 2026-05-30 at 5 53 54 PM" src="https://github.com/user-attachments/assets/9ec58813-b805-4a65-b83e-6d8a0914da61" />
<img width="1391" height="385" alt="Screenshot 2026-05-30 at 6 00 07 PM" src="https://github.com/user-attachments/assets/834c7616-440e-40d6-a2b1-d4204806a078" />
<img width="1372" height="688" alt="USERS PART 1" src="https://github.com/user-attachments/assets/3ea187da-b1f8-426b-bdd6-e9e129891df4" />

