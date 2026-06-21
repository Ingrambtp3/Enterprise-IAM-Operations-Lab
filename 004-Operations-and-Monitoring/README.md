# 004 — Operations and Monitoring
 
This phase covers the operational layer of the ByteKage lab — audit logging,
sign-in monitoring, the Identity Protection licensing wall, and the runbooks
used to respond to identity events.
 
**Status:** 🔄 In Progress — Audit log and sign-in log analysis complete with
documented evidence. Identity Protection licensing notes and runbooks complete.
 
---
 
## Table of Contents
 
- [A note on licensing](#a-note-on-licensing)
- [Audit Log Analysis](#audit-log-analysis)
- [Sign-In Log Analysis](#sign-in-log-analysis)
- [Identity Protection — Licensing Notes](#identity-protection--licensing-notes)
- [Runbooks](#runbooks)
- [Related Phases](#related-phases)
---
 
## A note on licensing
 
Audit logs and sign-in logs are **fully available on Entra ID Free tier** — no
P1/P2 required to access them. The real constraint is **retention**: Free tier
keeps only 7 days of log data, versus 30 days on P1/P2. The analysis below was
built from live, real-time events generated specifically for this phase, since
earlier-phase activity had already aged out of the retention window by the
time this phase started.
 
Identity Protection's risk policies and reports, by contrast, are genuinely
gated behind P2 — same honest-documentation pattern as Phase 2 (Conditional
Access) and Phase 3 (PIM).
 
---
 
## Audit Log Analysis
 
### Entry 1 — Add member to group
 
**Activity:** Add member to group · **Category:** GroupManagement
**Date:** 6/21/2026, 12:20:55 PM · **Status:** Success
 
The test admin account `adm.testuser` was added as a member of the
**ByteKage-Contractors** group via the Entra admin center.
 
<img src="screenshots/audit-log-activity-redacted.png" width="420" /> <img src="screenshots/audit-log-target-details-redacted.png" width="420" />
 
The log captures **two targets** for a single membership change — the user
object being added and the group object being modified. Object IDs and the
user's UPN are redacted above for portfolio publication; in the live portal
both are fully visible and clickable.
 
One quirk worth noting: **Group Type** returns `unknownFutureValue` — a
Microsoft Graph enum placeholder used when the API encounters a property it
doesn't have a defined label for in this schema version. Not a bug, just a
reminder that Graph responses don't always map cleanly to friendly portal
labels.
 
The **Initiated by (actor)** section confirms the change was made by an
interactive admin (Type: User), not a service principal — relevant because the
same activity type could just as easily originate from an automated process
(e.g. a SCIM connector or Graph API script), and the audit log is the only
place that distinction is recorded.
 
**Modified Properties:**
 
<img src="screenshots/audit-log-modified-properties-redacted.png" width="420" />
| Target | Property | Old Value | New Value |
|---|---|---|---|
| adm.testuser | Group.ObjectID | — | `[redacted]` |
| adm.testuser | Group.DisplayName | — | "Bytekage-Contractors" |
 
### Entry 2 — Update group
 
**Activity:** Update group · **Category:** GroupManagement
**Date:** 6/21/2026, 12:24:10 PM · **Status:** Success
 
<img src="screenshots/audit-log-list-view.png" width="420" />
The **ByteKage-Contractors** group description was edited directly in the
portal — a deliberate, low-risk change made to generate a clean "Update group"
audit event for this artifact.
 
<img src="screenshots/audit-log2-activity-redacted.png" width="420" /> <img src="screenshots/audit-log2-target-redacted.png" width="420" />
 
**Modified Properties — the real evidence:**
 
<img src="screenshots/audit-log2-modified-properties.png" width="420" />
| Target | Property | Old Value | New Value |
|---|---|---|---|
| Bytekage-Contractors | Description | `["Non-employee lifecycle testing"]` | `["Non-employee lifecycle testing 2.0"]` |
| Bytekage-Contractors | Included Updated Properties | — | "Description" |
| Bytekage-Contractors | TargetId.Group... | — | "" |
 
This is the cleanest possible demonstration of what the audit log is *for*: a
verifiable, timestamped before/after record. No screenshot of the group's
current state proves what changed or when — only the audit log does. In an
incident response or compliance context, this is the artifact you'd pull to
answer "who changed this, and what did it say before?"
 
### Audit log key takeaways
 
- Audit logs are fully available on Free tier — the licensing wall here is
  *retention* (7 days), not *access*.
- A single user-facing action generates multiple structured log entries —
  Activity, Target(s), and Modified Properties each answer a different
  investigative question (what happened / what was affected / what exactly
  changed).
- The **Modified Properties** tab with old value → new value is the actual
  audit evidence. Activity and Target provide context; this tab provides
  proof.
- Because retention is only 7 days on Free tier, any real operational use of
  this tenant would require exporting logs to Azure Storage or a Log
  Analytics workspace immediately — waiting until you need historical data is
  too late.
---
 
## Sign-In Log Analysis
 
### Basic info
 
<img src="screenshots/signin-basic-info-redacted.png" width="420" />
| Field | Value |
|---|---|
| Date | 2026-06-21T16:11:57Z |
| Status | Success |
| Authentication requirement | Single-factor authentication |
| Additional details | MFA requirement satisfied by claim in the token |
| Continuous access evaluation | No |
 
**The interesting nuance:** at first glance, "Authentication requirement:
Single-factor authentication" looks like a finding — did MFA not fire? The
**Additional details** field clarifies what actually happened: *"MFA
requirement satisfied by claim in the token."* MFA wasn't skipped — it was
already satisfied earlier in the session, and Entra honored that prior MFA
claim rather than re-prompting. Normal, expected behavior, but easy to
misread if you only look at the top-line field instead of the full context.
Don't diagnose a sign-in from one field in isolation.
 
Request ID and Correlation ID are redacted above — unique per-event
identifiers with no investigative value once isolated from the live tenant.
 
### Conditional Access evaluation
 
<img src="screenshots/signin-conditional-access.png" width="420" />
| Policy | Grant Controls | Session Controls | Result |
|---|---|---|---|
| Microsoft-managed: Multifactor... | Mfa | SignInFrequency | Not applied |
| CA Enforce MFA for MFA TEST G... | Mfa | — | Not applied |
 
**"Not applied" on this tab is not the same as "report-only."** This tab
reflects policies currently set to **On** (enforced). "Not applied" here means
the policy was in scope to be evaluated but its assignment conditions didn't
match this specific sign-in — most likely because the test policy is scoped
to a group this admin account isn't a member of.
 
### Report-only policy drill-down — the real evidence
 
Drilling into the separate **Report-only** tab surfaced the actual report-only
policy from Phase 2, evaluating against this real sign-in:
 
<img src="screenshots/signin-reportonly-policy-detail.png" width="420" />
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
 
This is the most useful single screenshot from the whole session — it doesn't
just show *that* the policy didn't apply, it shows **exactly which assignment
condition failed**. The resource condition matched correctly; the user
condition didn't. That's a precise, evidence-backed answer to "why didn't this
policy fire," pulled straight from the platform rather than inferred. It's
also proof the report-only Phase 2 policies are actively evaluating live
sign-in traffic and logging a would-be result — the entire point of running
Conditional Access in report-only mode before enforcing it.
 
### Sign-in log key takeaways
 
- Sign-in logs are fully available on Free tier with 7-day retention — same
  licensing pattern as audit logs.
- A sign-in's top-line fields can be misleading in isolation; always
  cross-reference "Additional details" before drawing a conclusion.
- The **Conditional Access** tab shows enforced policies; the **Report-only**
  tab shows policies still in evaluation mode — not interchangeable views of
  the same data.
- Per-assignment match/no-match detail (user vs. resource vs. location vs.
  device) is the actual diagnostic tool for "why didn't this policy apply" —
  far more useful than the policy-level result alone.
---
 
## Identity Protection — Licensing Notes
 
**Status:** Documented, not built — same honest pattern as Phase 2
(Conditional Access) and Phase 3 (PIM).
 
### What Identity Protection does
 
Identity Protection is Entra ID's risk-detection engine. It evaluates sign-ins
and user accounts against Microsoft's threat intelligence and behavioral
signals — impossible travel, anonymous IP usage, leaked credential matches,
atypical sign-in patterns — and assigns a **risk level** (low/medium/high) to
the user and the individual sign-in. That risk level can feed Conditional
Access policies ("require MFA if sign-in risk is medium or higher," "block
access if user risk is high") for automated, risk-based response instead of
static rules.
 
### What's actually available on Free tier
 
The Identity Protection blade is visible in the portal, but the functional
pieces that make it useful are gated:
 
| Capability | Free tier | P2 |
|---|---|---|
| Identity Protection dashboard (shell) | ✅ Visible | ✅ |
| Risky users report | ❌ | ✅ |
| Risky sign-ins report | ❌ | ✅ |
| Risk detections report | ❌ | ✅ |
| User risk policy | ❌ | ✅ |
| Sign-in risk policy | ❌ | ✅ |
| Risk-based Conditional Access | ❌ | ✅ |
 
Without P2, no risk scoring is happening in this tenant — the dashboard is
present, but the engine behind it isn't licensed to run.
 
### Where this would plug into work already built
 
- **Phase 2 (Conditional Access):** the report-only "MFA for All" policy
  documented above could be extended with a risk-based condition — require
  MFA automatically when sign-in risk is medium or higher, rather than
  relying solely on static user/location assignment.
- **This phase's runbooks:** the "Suspicious sign-in response" runbook below
  is written as if a risky sign-in alert exists to trigger it. With P2, that
  trigger would be a real Identity Protection alert instead of a manually
  reviewed sign-in log.
- **Phase 3 (PIM):** risky user detections are a standard trigger for forcing
  re-verification or revoking active privileged role assignments — another
  natural P2 dependency on top of the PIM work already documented.
### Why this gets documented instead of built
 
Pretending to screenshot a P2 feature on a Free tier tenant would misrepresent
the work. The honest version of this artifact is the licensing wall itself —
knowing exactly where Free tier stops, what P2 adds, and how the pieces would
connect if it were licensed is itself a demonstration of understanding the
product, not just clicking through a UI.
 
---
 
## Runbooks
 
### Suspicious Sign-In Response
 
**Trigger:** A sign-in is flagged as risky — in a fully-licensed tenant, this
would be an Identity Protection risky sign-in alert (see above for why that's
not available on Free tier here). In this lab, the equivalent trigger is
manual review of the sign-in log for anomalies: unexpected location, failed
MFA, impossible travel, or a sign-in outside normal hours for that account.
 
**Investigation steps:**
1. **Identity** → **Monitoring & Health** → **Sign-in logs**, filter by the
   affected user and a tight date range around the suspicious event.
2. Open the sign-in entry's **Basic info** tab — check Status, Authentication
   requirement, and Additional details (the latter can clarify what the
   top-line fields don't, e.g. an MFA claim satisfied earlier in the session).
3. Check **Location** and **Device info** for IP, geography, and device
   compliance state.
4. Check the **Conditional Access** tab — did an enforced policy apply, and
   what was the grant result? Then check **Report-only** — would a
   not-yet-enforced policy have caught this if it were live?
5. Cross-reference the **audit logs** for the same window — did this sign-in
   precede any directory changes? A suspicious sign-in followed immediately by
   a privilege change is a much higher priority than the sign-in alone.
**Response action:**
- If risk is confirmed: revoke active sessions, reset credentials, review any
  changes made during the session via audit logs.
- If the account holds a PIM-eligible role, check whether the role was
  activated during or near the suspicious window.
- Document the finding and decision — note the outcome even if it's "reviewed,
  not malicious."
**Owner:** Tier 1 Identity/Security operations. Escalate to Tier 2 if the
account holds any privileged role assignment or the sign-in correlates with a
directory change.
 
---
 
### Account Disable (Leaver)
 
**Trigger:** Offboarding initiated — an employee, contractor, or consultant
identity needs to be deactivated and stripped of access.
 
This one's already built, not just documented — see the Phase 7 Ansible
offboarding playbook in `007-Automation-IaC/ansible/`.
 
**Investigation steps (before running it):**
1. Confirm the correct account is targeted — verify UPN against the
   offboarding request, not just display name (display names can collide).
2. Check current group memberships and active role assignments so there's a
   pre-disable snapshot to compare against post-disable.
**Response action:**
1. Run the Ansible offboarding playbook against the target account. It
   disables the account (`accountEnabled: false`), removes group memberships,
   and logs the action — with `changed_when:` conditions tuned so the log
   accurately reflects whether a real state change occurred, not just that
   the API call succeeded (Ansible's `uri` module reports `ok` regardless of
   whether anything actually changed).
2. Verify the result. Don't trust `az ad user show --query accountEnabled` —
   it returns null by default. Use `az rest` with `$select=accountEnabled`
   for an accurate read.
3. Pull the audit log entry for the disable action and confirm it matches the
   pre-disable snapshot — every group removed should show up as a discrete
   "Remove member from group" event.
**Owner:** HR-initiated trigger, executed by Identity/IT operations. Retain
audit log evidence (export to storage if it needs to survive past the 7-day
Free tier retention window) for any compliance-relevant offboarding.
 
---
 
### PIM Activation Audit
 
**Trigger:** A privileged role is activated through PIM.
 
**Note on scope:** PIM itself is documented-not-built in this lab (Free tier
lacks P2, and the P2 trial was already used — see Phase 3). This runbook is
written as the procedure that *would* run if PIM were active, using the same
audit log investigation skills demonstrated above.
 
**Investigation steps:**
1. **Identity** → **Monitoring & Health** → **Audit logs**, filter Category to
   `RoleManagement`.
2. Check the **Activity** tab for who activated the role and when —
   "Initiated by (actor)" distinguishes an interactive admin action from
   anything automated.
3. Check **Target resources** for which role was activated and on which scope.
4. Check **Modified Properties** for the justification text provided at
   activation and the activation duration/expiration.
5. Cross-reference what the elevated account did during the active window —
   any directory changes should be reviewed against the stated justification.
**Response action:**
- Confirm the justification matches actual business need — a blank or vague
  justification for a Global Admin activation is itself a finding.
- If the activation pattern is unusual (off-hours, unfamiliar location, role
  not typically used by that person), treat it like a suspicious sign-in.
- Confirm the role correctly reverted to eligible-only once the activation
  window expired — standing access past the approved duration is a
  configuration failure, not just a monitoring gap.
**Owner:** Security operations, with escalation to the role's approving
authority for any Global Administrator or Application Administrator
activation.
 
---
 
### Guest Access Expiration
 
**Trigger:** An access review finding flags a guest/external identity whose
access should expire — either a scheduled access review cycle (Phase 3)
surfaces it, or a guest account is found with no recent sign-in activity.
 
**Investigation steps:**
1. **Identity** → **Users** → filter by **User type: Guest** for the current
   guest roster.
2. Check the **Sign-in logs** for last successful sign-in. On Free tier this
   only covers 7 days — if a guest hasn't signed in within that window, the
   log alone won't prove how long they've been inactive, so cross-reference
   `createdDateTime` and any prior access review records.
3. Check the audit log for the original grant — when was this guest invited,
   and to which group/resource?
4. Confirm current group memberships tied to the access in question.
**Response action:**
- If access was time-bounded (entitlement management access package with an
  expiration), confirm the expiration actually removed access, not just
  flagged it as expired.
- If access was open-ended, remove group membership and document the removal
  with the same audit-trail expectations as the Leaver runbook.
- If the guest disputes removal or business need is unclear, route back to
  the access review approver rather than unilaterally restoring access.
**Owner:** Access review approver (typically the resource/group owner) makes
the decision; Identity operations executes the removal and confirms via audit
log.
 
---
 
### Break-Glass Account Use
 
**Trigger:** Any sign-in from the break-glass Global Administrator account
(established in Phase 1). This account exists solely for emergency access —
it should have zero sign-in activity under normal operations. Any sign-in is
itself the alert.
 
**Investigation steps:**
1. **Identity** → **Monitoring & Health** → **Sign-in logs**, filter by the
   break-glass account's UPN. In a properly configured tenant this should
   normally return nothing.
2. If a sign-in is found, check Date/time, Location, Device info — authorized
   emergency use, or unexplained?
3. Pull the audit log for the same session window — what did the account do
   once signed in? Break-glass accounts typically bypass Conditional Access
   by design, so the audit log of *actions taken*, not the sign-in policies
   applied, is the real evidence.
4. Confirm whether this was a planned credential rotation/test or genuinely
   unplanned.
**Response action:**
- If unauthorized: treat as a critical incident. Rotate the credential
  immediately, audit every action taken during the session, review how the
  credential could have been accessed.
- If authorized: document the reason, confirm the credential was rotated
  afterward per standard break-glass hygiene, confirm normal admin accounts
  are functional again before closing out.
- A break-glass sign-in event should never go undocumented — the whole point
  of the account is that its use is rare enough that every instance gets full
  scrutiny.
**Owner:** Highest-priority escalation — Security leadership / IAM lead, not
standard Tier 1 operations.
 
---
 
## Related Phases
 
- Depends on: Phase 3 (Governance) — PIM and Access Review events are primary
  alert sources
- Feeds into: Phase 5 (Case Scenarios) — operational responses feed scenario
  documentation
