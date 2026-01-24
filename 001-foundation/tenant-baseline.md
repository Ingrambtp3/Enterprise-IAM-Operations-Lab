# Tenant Baseline

## Purpose
This document defines the baseline identity and security posture of the tenant.
All access control, governance, and automation decisions build on this foundation.

## Baseline Philosophy
- Secure by default
- Least privilege by design
- Explicit configuration over implicit trust
- Human and non-human identities are treated differently

## Tenant-Level Security Defaults
- Security defaults are evaluated and intentionally disabled or replaced
- Custom Conditional Access policies are preferred for granular control
- Legacy authentication is disabled tenant-wide

## Authentication Methods
- Modern authentication is required for all users
- MFA is enforced for all interactive sign-ins
- Stronger MFA requirements apply to privileged roles
- Password-based authentication is supplemented with MFA
- Passwordless methods are evaluated but not assumed by default

## Administrative Protections
- Administrative roles are assigned to separate privileged accounts
- Privileged roles are not permanently assigned where avoidable
- Emergency (break-glass) accounts exist with strong compensating controls
- Privileged access is monitored and logged

## Identity Exposure Surface
- External identities (guests) are restricted by default
- App registrations and service principals are reviewed and controlled
- Non-human identities follow least-privilege and scoped permissions

## Logging & Visibility
- Sign-in logs are enabled and retained
- Audit logs are enabled and reviewed periodically
- Privileged actions are traceable to individual identities

## Baseline Assumptions
- This tenant represents a production-like environment
- All deviations from this baseline are documented
- Baseline decisions are revisited as the environment matures
