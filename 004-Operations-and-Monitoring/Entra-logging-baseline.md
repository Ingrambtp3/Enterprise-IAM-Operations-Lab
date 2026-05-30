# Entra Logging Baseline

## Purpose
Define which identity-related logs are enabled, retained, and reviewed
to support access governance, security monitoring, and investigations.

## Log Categories

### Sign-In Logs
Used to observe authentication activity.
Includes:
- Successful and failed sign-ins
- MFA challenges and outcomes
- Conditional Access evaluations
- User, guest, and admin sign-ins

Primary Uses:
- Detect abnormal sign-in behavior
- Validate Conditional Access enforcement
- Investigate authentication incidents

### Audit Logs
Used to observe identity and directory changes.
Includes:
- User and group changes
- Role assignments and removals
- Application and service principal changes
- Policy modifications

Primary Uses:
- Track access changes
- Validate governance actions
- Support audits and investigations

### Privileged Activity Logs
Used to observe elevated access usage.
Includes:
- Privileged role activations
- Role assignment changes
- Privileged actions performed

Primary Uses:
- Validate privileged access governance
- Detect misuse or over-privilege
- Support incident response

## Log Retention
- Logs are retained based on security and audit needs
- Retention decisions balance cost and risk
- Critical identity events must remain reviewable

## Governance Alignment
- Logs support access reviews and lifecycle decisions
- Privileged access logs support elevation oversight
- Guest activity logs support external identity governance

## Baseline Assumptions
- Logging is enabled before detection rules are created
- Absence of logs is treated as a visibility risk
- Logging configuration changes are documented
