# Identity Lifecycle Governance

## Purpose
Define how access is granted, modified, and removed as identities move through
their lifecycle in the organization.

## Lifecycle Stages

### Joiner
When an identity is created:
- Identity is provisioned with baseline access only
- Access is granted via role - or group-based assignment
- No privileged access is granted by default
- MFA is enforced before access is usable

### Mover
When an identity changes roles or responsibilities:
- Existing access is reviewed
- New access is granted based on updated role
- Unneeded access is removed
- Privileged access is re-evaluated

### Leaver
When an identity leaves the organization:
- Access is revoked promptly
- Sessions are invalidated
- Group memberships are removed
- Privileged role assignments are revoked
- Guest sponsorship is reviewed where applicable

## Privileged Identity Lifecycle
- Privileged accounts are created separately
- Privileged access is temporary and role-specific
- Standing administrative access is avoided
- Privileged access usage is logged and reviewed

## Failure Handling
- Incomplete lifecycle actions are treated as risk
- Orphaned access is investigated and remediated
- Lifecycle failures are documented

## Governance Notes
- Lifecycle rules apply to all identity types
- Exceptions must be documented and approved
