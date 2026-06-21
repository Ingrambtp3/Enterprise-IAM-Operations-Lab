# Sign-In Log Analysis — ByteKage Tech Services Lab

**Phase:** 4 — Operations & Monitoring
**Environment:** Microsoft Entra ID (Free tier, ByteKage tenant)
**Date documented:** June 21, 2026

---

## Methodology note

Same retention reality as the audit log analysis: Entra ID Free tier keeps sign-in
log data for 7 days. This analysis documents a live, real interactive sign-in rather
than relying on data that may have already aged out.

---

## Basic info

![Sign-in basic info](screenshots/signin-basic-info-redacted.png)

| Field | Value |
|---|---|
| Date | 2026-06-21T16:11:57Z |
| Status | Success |
| Authentication requirement | Single-factor authentication |
| Additional details | MFA requirement satisfied by claim in the token |
| Continuous access evaluation | No |

### The interesting nuance

At first glance, **"Authentication requirement: Single-factor authentication"**
looks like a finding — did MFA not fire? But the **Additional details** field
clarifies what actually happened: *"MFA requirement satisfied by claim in the
token."*

This means MFA wasn't skipped — it was already satisfied earlier in the session,
and Entra honored that prior MFA claim rather than re-prompting. This is normal,
expected behavior (session tokens carrying forward an MFA claim rather than
forcing re-authentication on every single sign-in), but it's exactly the kind of
detail that's easy to misread as a security gap if you only look at the top-line
"Authentication requirement" field instead of reading the full context. Worth
remembering for both the lab and the SC-300: don't diagnose a sign-in from one
field in isolation.

Request ID and Correlation ID are redacted in the screenshot — these are unique
per-event identifiers with no investigative value once isolated from the live
tenant, but they're the kind of token that shouldn't be published regardless.

---

## Conditional Access evaluation

![Conditional access tab](screenshots/signin-conditional-access.png)

| Policy | Grant Controls | Session Controls | Result |
|---|---|---|---|
| Microsoft-managed: Multifactor... | Mfa | SignInFrequency | Not applied |
| CA Enforce MFA for MFA TEST G... | Mfa | — | Not applied |

**"Not applied" on this tab is not the same as "report-only."** This tab reflects
policies currently set to **On** (enforced). "Not applied" here means the policy
was in scope to be evaluated but its assignment conditions didn't match this
specific sign-in — most likely because the test policy is scoped to a specific
group ("MFA TEST G...") that this admin account isn't a member of.

---

## Report-only policy drill-down — the real evidence

Drilling into the separate **Report-only** tab surfaced the actual report-only
policy from Phase 2, evaluating against this real sign-in:

![Report-only policy detail](screenshots/signin-reportonly-policy-detail.png)

| Field | Value |
|---|---|
| Policy | MFA for All |
| Policy state | Report-only |
| Result | Report-only: Not applied |

**Assignments:**

| Assignment | Status |
|---|---|
| User: Allon Ingram | ❌ Not matched |
| Resource: Azure Resource Manager | ✅ Matched |

This is the most useful single screenshot from the whole session. It doesn't just
show *that* the policy didn't apply — it shows **exactly which assignment condition
failed**. The resource condition (Azure Resource Manager) matched correctly; the
user condition didn't. That's a precise, evidence-backed answer to "why didn't this
policy fire," pulled straight from the platform rather than inferred.

This is also proof the report-only Phase 2 policies aren't just configured and
forgotten — they're actively evaluating live sign-in traffic and logging a
would-be result, which is the entire point of running Conditional Access in
report-only mode before turning on enforcement.

---

## Key takeaways

- Sign-in logs are fully available on Free tier with 7-day retention — same
  licensing pattern as audit logs.
- A sign-in's top-line fields (like "Authentication requirement") can be
  misleading in isolation; always cross-reference "Additional details" before
  drawing a conclusion.
- The **Conditional Access** tab shows enforced policies; the **Report-only**
  tab shows policies still in evaluation mode. They are not interchangeable views
  of the same data — conflating them would misrepresent what's actually being
  enforced versus simulated.
- Per-assignment match/no-match detail (user vs. resource vs. location vs. device)
  is the actual diagnostic tool for "why didn't this policy apply" — far more
  useful than the policy-level result alone.
