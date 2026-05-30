# Group Design

## Purpose
This document defines how groups are structured, named, and used to grant access.
Groups are the primary mechanism for access control in this environment.

## Design Principles
- Groups represent access, not people
- Users are assigned to groups; groups are assigned to resources
- Direct user-to-resource assignments are avoided
- Group purpose is clear from the name alone

## Group Categories
Groups fall into distinct categories to prevent overlap and confusion.

### Baseline Access Groups
Used to provide standard access required by most users.
- Example: baseline-user-access
- Example: baseline-mfa-required

### Application Access Groups
Used to grant access to specific applications.
- Example: app-m365-users
- Example: app-salesforce-users

### Role-Based Groups
Used to represent business or technical roles.
- Example: role-finance-user
- Example: role-it-support

### Administrative Groups
Used to control privileged role assignment and elevation.
- Example: admin-global-reader
- Example: admin-identity-admin

### Guest Access Groups
Used exclusively for external identities.
- Example: guest-app-portal-access

## Naming Convention
Group names follow a predictable format:
- <(category)>-<(scope)>-<(purpose)>

Examples:
- baseline-user-access
- app-entra-admin-portal
- role-hr-user
- admin-privileged-role

## Assignment Rules
- Users are assigned to baseline and role groups only
- Applications and roles are assigned to groups, not users
- Administrative groups are assigned to privileged identities only
- Guest users are never placed in internal user groups

## Governance & Maintenance
- Group membership is reviewed periodically
- Groups without a clear owner or purpose are candidates for removal
- Changes to group design are documented
