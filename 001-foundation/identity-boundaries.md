# Identity Boundaries

## Purpose
This document defines non-negotiable boundaries for identities in this environment.
These boundaries prevent privilege creep, reduce risk, and enforce consistent access behavior.

## Standard User Boundaries
Standard user identities:
- Must never hold administrative roles
- Must not bypass MFA or conditional access controls
- Must not create or manage app registrations
- Must not access privileged resources by default

## Privileged Identity Boundaries
Privileged identities:
- Are separate from standard user accounts
- Are used only for administrative tasks
- Are granted elevated roles temporarily where possible
- Must authenticate using stronger controls than standard users
- Are continuously monitored and audited

## Guest Identity Boundaries
Guest identities:
- Are denied access by default
- Receive only explicitly granted permissions
- Are time-bound and reviewed periodically
- Must not hold privileged roles
- Are removed when no longer required

## Non-Human Identity Boundaries
Service principals and managed identities:
- Are granted only the minimum permissions required
- Must be documented with ownership and purpose
- Are reviewed periodically for necessity and scope
- Must not be reused across unrelated applications

## Emergency Access Boundaries
Break-glass accounts:
- Exist solely for emergency access
- Are excluded from standard access policies intentionally
- Are protected with strong credentials and monitoring
- Are tested periodically but used rarely

## Enforcement & Exceptions
- Boundary violations are treated as security issues
- Exceptions require documented justification and approval
- Temporary exceptions must include an expiration and review plan

## Boundary Review
- Identity boundaries are reviewed as the environment evolves
- Changes to boundaries are documented and versioned
