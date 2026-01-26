# Application Access Patterns

## Purpose
This document defines standardized patterns for onboarding, assigning, and governing
application access. The goal is consistency, least privilege, and auditability.

## Application Onboarding Principles
- Applications are onboarded intentionally, not ad-hoc
- Access is granted through groups, not directly to users
- Authentication and authorization are centrally enforced
- Every application has an owner

## Standard Application Onboarding Flow
1. Application is identified and approved
2. Authentication method is selected (SSO preferred)
3. Application access groups are created
4. Groups are assigned to the application
5. Conditional Access policies are applied
6. Access is reviewed periodically

## Authentication Patterns
- Single Sign-On (SSO) is preferred where supported
- Modern authentication protocols are required
- Legacy authentication methods are avoided
- MFA is enforced via Conditional Access, not app-specific controls

## Authorization Patterns
- Application access is granted via group membership
- Role-based access within applications is mapped to groups where possible
- Direct user assignments are avoided
- Privileged application roles are restricted to admin identities

## Access Lifecycle
- Access is granted based on role or function
- Access changes occur through group membership updates
- Access is revoked automatically when group membership is removed
- Guest access is time-bound and reviewed

## Conditional Access Alignment
- All applications inherit baseline Conditional Access policies
- Sensitive applications receive additional protections
- Exceptions are documented and reviewed

## Governance & Review
- Application access is reviewed periodically
- Orphaned applications and unused access groups are identified
- Application owners are responsible for access validation
