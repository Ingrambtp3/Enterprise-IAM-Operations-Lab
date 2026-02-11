# Case Scenario — Mid-Sized Cloud-First Organization

## Organization Overview
The organization is a mid-sized, cloud-first company operating in a regulated
industry with moderate risk tolerance.

- Employees: ~250
- IT Staff: Small centralized team
- Identity Platform: Microsoft Entra ID
- Applications: Microsoft 365, internal line-of-business apps, third-party SaaS
- Access Model: Group-based access with role separation

The organization relies heavily on identity as the primary security control.

## Identity Landscape
The environment includes:
- Standard users performing day-to-day business tasks
- Privileged administrators managing identity and access
- Guest users such as vendors and contractors
- Applications using service principals and app registrations

Administrative access is intentionally segregated and governed.

## Themed Identity Model

To make the scenario more concrete and easier to visualize, users and roles are modeled using MLB team personas.

These teams represent functional groups within the organization:

- Braves – Standard business users (general workforce)
- Yankees – Finance and sensitive data users
- Dodgers – Engineering and application owners
- Red Sox – IT support and operations staff
- Astros – Security and identity administrators
- Cubs – External partners and vendors (guest users)

This naming approach is used purely for demonstration purposes to make access patterns easy to follow and test.

## Example Access Problems Using the Themed Model

Over time, the following issues may occur:

- A user originally in the “Braves” group moves to the “Dodgers” team but retains previous access.
- A “Red Sox” IT support user receives temporary admin rights but never has them removed.
- An external contractor in the “Cubs” group finishes a project but remains active.
- A service account tied to the “Yankees” group keeps elevated permissions it no longer needs.

These scenarios represent real-world identity governance failures in a relatable format.

The organization is concerned about:
- Excessive permissions
- Unreviewed privileged access
- Inability to prove access controls are working

## Governance Expectations
The organization expects that:
- Access is granted based on role and business need
- Access is reviewed regularly and removed when no longer required
- Privileged access is time-bound and monitored
- Guest access expires or is revalidated
- All access changes are auditable

## Operational Expectations
The organization requires:
- Visibility into sign-ins, access changes, and privileged activity
- Evidence that governance controls are enforced
- Ability to investigate identity-related incidents
- Confidence that access violations would be detected

## Success Criteria
The IAM program is considered successful when:
- Access aligns with documented roles and boundaries
- Governance actions can be validated with logs
- Privileged access misuse can be detected and investigated
- Guest access does not persist beyond business need
- Evidence exists to support audits and reviews
