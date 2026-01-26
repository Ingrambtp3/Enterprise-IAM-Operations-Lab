# RBAC Strategy

## Purpose
This document defines how Role-Based Access Control (RBAC) is implemented to manage
permissions across identities while enforcing least privilege and accountability.

## RBAC Principles
- Roles grant permissions; users do not receive permissions directly
- Administrative access is segregated from standard user access
- Privileged roles are assigned temporarily wherever possible
- Every role assignment must be explainable and auditable

## Role Categories

### Directory-Level Roles
High-impact roles with broad permissions.
- Examples: Global Reader, Identity Administrator, User Administrator
- Assigned only to privileged identities
- Permanent assignment is avoided when possible

### Application-Specific Roles
Roles scoped to individual applications or services.
- Examples: App Administrator, Exchange Administrator
- Assigned via groups or elevation paths
- Used instead of directory-wide roles when possible

### Read-Only Roles
Used for visibility without change capability.
- Examples: Global Reader, Security Reader
- Preferred for audit, monitoring, and troubleshooting tasks

## Assignment Strategy
- Standard users are never assigned directory roles
- Privileged roles are assigned to groups or via elevation mechanisms
- Direct user-to-role assignments are avoided
- Role assignments are documented with justification

## Privileged Access Model
- Privileged identities use separate admin accounts
- Elevated access is time-bound and approved
- Standing administrative access is minimized
- Privileged actions are logged and reviewed

## Emergency Access
- Break-glass accounts exist for tenant recovery
- Accounts are excluded from normal access controls intentionally
- Use of emergency access is logged and investigated
- Credentials are stored securely and rotated periodically

## Governance & Review
- Role assignments are reviewed periodically
- Unused or excessive roles are removed
- RBAC decisions are revisited as the environment evolves
