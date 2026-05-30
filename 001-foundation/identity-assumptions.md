# Identity Assumptions

This document defines the baseline assumptions about identities in this environment.
These assumptions inform access design, security controls, and automation decisions.

## Identity Types
- Standard Users
- Privileged / Administrative Users
- Guest / External Users
- Service Accounts (non-human identities)

## General Assumptions
- All interactive users are cloud-backed identities
- Administrative access is segregated from standard user access
- Guest access is explicitly granted and reviewed
- Non-human identities are minimized and monitored

## Authentication Assumptions
- MFA is required for all interactive users
- Strong authentication is enforced for privileged roles
- Legacy authentication is disabled wherever possible

## Risk & Trust Model
- No identity is implicitly trusted
- Access decisions consider user risk and sign-in context
- Elevated access is time-bound and auditable
