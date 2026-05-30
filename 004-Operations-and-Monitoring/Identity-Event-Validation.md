# Identity Event Validation

## Purpose
Define expected identity-related events and the corresponding logs that validate
access controls, governance actions, and security enforcement.

This document answers: “When something happens, how do we know?”

## Validation Philosophy
- Every critical IAM action should produce evidence
- Absence of expected logs is treated as a control failure
- Logs validate both prevention and detection controls
- Events must be traceable to identities

## Identity Events and Expected Evidence

### User Sign-In
Event:
- Standard user attempts sign-in

Expected Evidence:
- Sign-in log entry
- Authentication result (success/failure)
- MFA challenge and outcome (if applicable)
- Conditional Access evaluation

Validation Purpose:
- Confirm authentication enforcement
- Confirm MFA and CA policy behavior

---

### Failed or Risky Sign-In
Event:
- Failed authentication or risky sign-in attempt

Expected Evidence:
- Sign-in log with failure reason
- Risk indicators (where applicable)
- Conditional Access decision

Validation Purpose:
- Detect brute force or anomalous activity
- Validate risk-based controls

---

### Group Membership Change
Event:
- User added to or removed from a group

Expected Evidence:
- Audit log entry
- Actor identity recorded
- Timestamp and target group documented

Validation Purpose:
- Validate access grant or revocation
- Support access reviews and investigations

---

### Application Access Assignment
Event:
- Group assigned to an application
- User gains application access via group

Expected Evidence:
- Audit log entry for assignment
- Subsequent sign-in log showing access

Validation Purpose:
- Confirm application access model
- Validate group-based access flow

---

### Privileged Role Activation
Event:
- Privileged role activated (e.g., PIM-style elevation)

Expected Evidence:
- Privileged access activation log
- Role name, duration, and requester recorded
- Approval event (if required)

Validation Purpose:
- Validate privileged access governance
- Confirm time-bound elevation

---

### Privileged Role Assignment Change
Event:
- Privileged role assigned or removed

Expected Evidence:
- Audit log entry
- Actor and target identity recorded
- Role scope documented

Validation Purpose:
- Detect privilege escalation
- Validate RBAC enforcement

---

### Guest User Invitation
Event:
- Guest user invited to the tenant

Expected Evidence:
- Audit log entry
- Inviter identity recorded
- Guest user object created

Validation Purpose:
- Validate guest onboarding controls
- Support guest governance reviews

---

### Guest User Removal
Event:
- Guest access revoked or account removed

Expected Evidence:
- Audit log entry
- Removal action recorded
- Timestamp documented

Validation Purpose:
- Confirm guest lifecycle enforcement
- Support audit and cleanup evidence

---

### Conditional Access Enforcement
Event:
- Conditional Access policy blocks or allows access

Expected Evidence:
- Sign-in log showing policy evaluation
- Policy name and result recorded
- Enforcement outcome visible

Validation Purpose:
- Confirm CA policy effectiveness
- Support testing and tuning

---

## Validation Gaps
- Events without corresponding logs are investigated
- Logging gaps are treated as operational risk
- Validation failures inform control improvements

## Governance Alignment
- Validation supports Phase 3 governance decisions
- Validation evidence feeds Phase 6 testing scenarios
- Validation outputs become Phase 7 evidence artifacts
