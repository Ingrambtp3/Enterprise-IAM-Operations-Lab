# 002 — Access Control🛠️
 
**Phase:** 2 — Access Control
**Tenant:** ByteKage (ByteKage.onmicrosoft.com)
**Status:** 🔄 In Progress — Policies built. Full enforcement pending P1/P2 licensing.
**Date:** 2026-05-30
 
---
 
## What This Covers💻
 
Conditional Access (CA) is the policy enforcement layer of the ByteKage lab environment.
Every authentication request is evaluated against these policies before access is granted.
 
This phase documents the CA policies built in the tenant — what each one does,
who it targets, what conditions it evaluates, and why it exists.
 
---
 
## Licensing 📝
 
Full Conditional Access policy management requires Microsoft Entra ID P1 or P2.
This tenant is currently on the Free tier. The policies below were built during
a prior P2 trial period and remain in the tenant.
 
Current state:
- Microsoft-managed policy: **On**
- User-created policies: **Report-only** (cannot be enforced without active license)
- New policy creation: **Blocked** until P1/P2 is active
This is documented as a real operational constraint — not hidden.
The policy designs are valid and will be enforced once licensing is upgraded.
 
---
 
## Policies 📋
 
### 1 — Multifactor Authentication for Risky Sign-ins
**Created by:** Microsoft (managed policy)
**State:** On
**Created:** 2025-08-04
 
| Setting | Value |
|---|---|
| Target users | All users |
| Target resources | All resources |
| Condition | Sign-in risk detected |
| Grant control | Require MFA |
 
**Rationale:** Microsoft-managed policies apply baseline Zero Trust controls automatically.
This policy fires when Identity Protection detects a risky sign-in — compromised credentials,
impossible travel, anonymous IP, etc. MFA is required to complete the session.
This is the first line of defense against credential-based attacks.
 
---
 
### 2 — CA Enforce MFA for MFA TEST GROUP
**Created by:** User
**State:** On
**Created:** 2025-08-08
 
| Setting | Value |
|---|---|
| Target users | Specific users (MFA TEST GROUP) |
| Target resources | 1 resource included |
| Network | All trusted networks and locations |
| Conditions | 2 conditions selected |
| Grant control | Require MFA |
| Enable policy | On |
 
**Rationale:** Group-scoped MFA enforcement policy. Targets a specific group rather than
all users — this is the pattern used in production environments where MFA rollout
is phased by group before being applied tenant-wide. Testing MFA enforcement on a
controlled group before expanding scope is standard enterprise practice.
 
---
 
### 3 — MFA for All
**Created by:** User
**State:** Report-only
**Created:** 2025-03-29
 
| Setting | Value |
|---|---|
| Target users | Specific users included |
| Target resources | 1 resource included |
| Network | All trusted networks and locations |
| Conditions | 3 conditions selected (User risk, Sign-in risk, + 1) |
| User risk | 1 level included (requires P2) |
| Sign-in risk | 1 level included (requires P2) |
| Enable policy | Report-only |
 
**Rationale:** Tenant-wide MFA enforcement policy. Currently in Report-only mode —
this is the correct practice before enabling a broad policy. Report-only allows
you to see what the policy would have blocked without actually blocking anyone.
 
Risk-based conditions (User risk, Sign-in risk) require Entra ID P2.
These conditions are configured and ready — they will become active when P2 licensing
is applied to the tenant.
 
**Why Report-only is intentional:**
Enabling a tenant-wide MFA policy without testing it first is how organizations
accidentally lock out users or break service accounts. Report-only is not a
limitation — it is a control. The policy is designed. The enforcement waits
for license and validation.
 
---
 
## Policies Designed but Not Yet Built 📍
 
These policies will be created when P1/P2 licensing is active:
 
| Policy | Purpose | License Required |
|---|---|---|
| Block Legacy Authentication | Legacy protocols bypass MFA — must be blocked | P1 |
| Require MFA for Admin Roles | Additional MFA enforcement scoped to admin accounts | P1 |
| Block Risky Users | Automatically block users flagged as high risk | P2 |
| Named Location — Trusted Locations | Define trusted IPs/locations for CA conditions | P1 |
 
---
 
## Design Principles
 
1. **Report-only before enforcement** — every policy runs in report-only before going live
2. **Group-scoped before tenant-wide** — test on a controlled group, then expand
3. **Break-glass excluded** — breakglass@ByteKage.onmicrosoft.com excluded from all CA policies
4. **Every exclusion documented** — no undocumented exceptions
---
 
## Status
 
🔄 In Progress — 3 policies exist in tenant. 2 user-created, 1 Microsoft-managed.
Full enforcement and new policy creation pending P1/P2 licensing upgrade.
 
## Related Phases
 
- Depends on: Phase 1 (Foundation) — groups and users are the targets of CA policies
- Feeds into: Phase 3 (Governance) — PIM-eligible roles operate within the CA framework defined here
 ## SCREENSHOTS 
 <img width="589" height="628" alt="Screenshot 2026-05-30 at 6 44 04 PM" src="https://github.com/user-attachments/assets/c914bb77-2a25-4beb-b052-95b84e5548e2" />
<img width="657" height="680" alt="Screenshot 2026-05-30 at 6 43 17 PM" src="https://github.com/user-attachments/assets/a58e6056-0df6-49c1-a126-396bb2234d5d" />
<img width="582" height="754" alt="Screenshot 2026-05-30 at 6 42 21 PM" src="https://github.com/user-attachments/assets/e35c222f-1d87-4c4f-bb87-208378b98e33" />
<img width="1357" height="696" alt="Screenshot 2026-05-30 at 6 37 46 PM" src="https://github.com/user-attachments/assets/69166caa-bd3a-4937-90be-c5a59f8ed9dc" />
