# Access Reviews

## Purpose
This document defines how access is periodically reviewed to ensure it remains
appropriate, justified, and aligned with identity governance principles.

## Review Philosophy
- Access must be owned by someone accountable
- Reviews occur on a predictable cadence
- Inaction during a review is treated as a decision
- Access that cannot be justified is removed

## Review Scope
Access reviews apply to:
- Group-based access
- Application access
- Privileged role assignments
- Guest and external identities

## Review Types

### Standard User Access Reviews
- Scope: Role-based and application access groups
- Reviewer: Access owner or manager
- Cadence: Quarterly
- Outcome: Access retained, modified, or removed

### Privileged Access Reviews
- Scope: Administrative roles and elevated permissions
- Reviewer: Security or IAM owner
- Cadence: Monthly
- Outcome: Continued eligibility, removal, or restriction

### Guest Access Reviews
- Scope: All guest identities and guest access groups
- Reviewer: Guest sponsor or application owner
- Cadence: Monthly or time-bound
- Outcome: Access retained or guest removed

## Review Decisions
Reviewers must explicitly choose:
- Approve access
- Remove access
- Modify access

Lack of response within the review window results in:
- Automatic access removal or escalation (depending on criticality)

## Exception Handling
- Exceptions require documented justification
- Exceptions must include an expiration date
- Expired exceptions are reviewed or revoked

## Audit & Evidence
- Review decisions are logged
- Review outcomes are retained for audit purposes
- Removal actions are traceable to a review decision

## Governance Notes
- Reviews are enforced, not optional
- Review results inform future access design decisions
