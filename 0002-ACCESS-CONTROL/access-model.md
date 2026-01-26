# Access Model Overview

## Purpose
This document defines how access is structured and granted in the environment.
It serves as the blueprint for RBAC, group design, and application assignments.

## Access Granting Strategy
- Users receive access through group membership
- Groups are mapped to roles or applications
- Direct user-to-resource assignments are avoided
- Privileged access follows a separate elevation path

## Identity-to-Access Flow
1. Identity is created
2. Identity is placed into baseline groups
3. Group membership determines access
4. Conditional Access evaluates sign-in context
5. Privileged access is elevated only when required

## Standard User Access
- Assigned baseline access groups
- Access limited to required applications
- No standing administrative permissions

## Privileged Access
- Privileged identities use separate accounts
- Roles are assigned via elevation where possible
- Privileged access is logged and reviewed

## Guest Access
- Guests are assigned to dedicated guest groups
- Access is scoped per application
- Access is reviewed and time-bound

## Non-Human Access
- Service principals are scoped to specific resources
- Permissions follow least privilege
- Ownership and purpose are documented
