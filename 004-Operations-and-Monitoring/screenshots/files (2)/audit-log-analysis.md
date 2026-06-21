# Audit Log Analysis — ByteKage Tech Services Lab

**Phase:** 4 — Operations & Monitoring
**Environment:** Microsoft Entra ID (Free tier, ByteKage tenant)
**Date documented:** June 21, 2026

---

## A note on methodology

Entra ID Free tier retains audit and sign-in log data for **7 days only** — there's
no way to extend this without routing logs to a Log Analytics workspace (a P1/P2-adjacent
capability we haven't built yet). That meant the audit trail from earlier lab phases
(Phase 1 user/group creation, Phase 2 CA policy work, Phase 7 Terraform provisioning)
had already rolled off the retention window by the time this phase started.

Rather than fake it with stale screenshots, this analysis documents two **live, real-time**
audit events generated specifically for this artifact — a more honest demonstration of
reading and interpreting the audit trail than a months-old screenshot would be.

---

## Entry 1 — Add member to group

**Activity:** Add member to group
**Category:** GroupManagement
**Date:** 6/21/2026, 12:20:55 PM
**Status:** Success

![Activity detail](screenshots/audit-log-activity-redacted.png)

### What happened

The test admin account `adm.testuser` was added as a member of the
**ByteKage-Contractors** group via the Entra admin center.

### Target detail

![Target detail](screenshots/audit-log-target-details-redacted.png)

The log captures **two targets** for a single membership change — the user object
being added and the group object being modified. Both Object IDs and the user's
UPN are redacted in the screenshot above for portfolio publication, but in the live
portal both are fully visible and clickable, linking directly to the object.

One quirk worth noting: the **Group Type** field returns `unknownFutureValue` — a
Microsoft Graph enum placeholder used when the API encounters a group property it
doesn't have a defined label for in this schema version. Not a bug — just a reminder
that Graph responses don't always map cleanly to friendly portal labels.

### Who initiated it

![Activity tab](screenshots/audit-log-activity-redacted.png)

The **Initiated by (actor)** section confirms the change was made by an interactive
admin (Type: User), not a service principal — relevant because the same activity type
could just as easily originate from an automated process (e.g. a SCIM provisioning
connector or a Graph API script), and the audit log is the only place that distinction
is recorded.

### Modified Properties

![Modified properties](screenshots/audit-log-modified-properties-redacted.png)

| Target | Property | Old Value | New Value |
|---|---|---|---|
| adm.testuser | Group.ObjectID | — | `[redacted]` |
| adm.testuser | Group.DisplayName | — | "Bytekage-Contractors" |

---

## Entry 2 — Update group

**Activity:** Update group
**Category:** GroupManagement
**Date:** 6/21/2026, 12:24:10 PM
**Status:** Success

![Audit log list view](screenshots/audit-log-list-view.png)

### What happened

The **ByteKage-Contractors** group description was edited directly in the portal —
a deliberate, low-risk change made specifically to generate a clean "Update group"
audit event for this artifact.

### Activity detail

![Activity tab entry 2](screenshots/audit-log2-activity-redacted.png)

### Target detail

![Target tab entry 2](screenshots/audit-log2-target-redacted.png)

### Modified Properties — the real evidence

![Modified properties entry 2](screenshots/audit-log2-modified-properties.png)

| Target | Property | Old Value | New Value |
|---|---|---|---|
| Bytekage-Contractors | Description | `["Non-employee lifecycle testing"]` | `["Non-employee lifecycle testing 2.0"]` |
| Bytekage-Contractors | Included Updated Properties | — | "Description" |
| Bytekage-Contractors | TargetId.Group... | — | "" |

This is the cleanest possible demonstration of what the audit log is *for*: a
verifiable, timestamped before/after record. No screenshot of the group's current
state proves what changed or when — only the audit log does. In an incident response
or compliance context, this is the artifact you'd pull to answer "who changed this,
and what did it say before?"

---

## Key takeaways

- **Audit logs and sign-in logs are fully available on Entra ID Free tier** — no P1/P2
  required. The licensing wall here is *retention* (7 days), not *access*.
- A single user-facing action (adding a group member, editing a description) generates
  multiple structured log entries — Activity, Target(s), and Modified Properties are
  separate views of the same event, each answering a different investigative question
  (what happened / what was affected / what exactly changed).
- The **Modified Properties** tab with old value → new value is the actual audit
  evidence. The Activity and Target tabs provide context; this tab provides proof.
- Because retention is only 7 days on Free tier, any real operational use of this
  tenant would require exporting logs to Azure Storage or a Log Analytics workspace
  immediately — waiting until you need historical data is too late.
