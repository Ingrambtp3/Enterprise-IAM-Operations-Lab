# Enterprise IAM Operations Lab

> A multi-phase, enterprise-style **Identity & Access Management** lab that simulates how identity is governed, secured, and operated in real organizations — built on **Microsoft Entra ID**, hybrid identity, and automation.

![Platform](https://img.shields.io/badge/Identity-Microsoft%20Entra%20ID-0078D4)
![Automation](https://img.shields.io/badge/Automation-PowerShell%20%7C%20Graph%20API-5391FE)
![Focus](https://img.shields.io/badge/Focus-IAM%20%7C%20Governance%20%7C%20Zero%20Trust-1f6feb)
![Status](https://img.shields.io/badge/Status-Active-success)
![License](https://img.shields.io/badge/License-MIT-green)

---

## Why This Lab Exists

Most IAM "labs" stop at clicking through a portal. This one is built like an operations environment: every change is **documented**, every decision is **justified**, every risk is **identified**, and every control is **validated**.

The goal is to demonstrate IAM **decision-making and operational thinking** — the judgment a hiring team actually pays for — not just feature configuration.

Maintained by **Allon Ingram** ([ByteKage](https://github.com/Ingrambtp3)) — IAM Analyst / System Administrator running a 600+ user hybrid Entra ID environment in production.

---

## What This Lab Covers

| Domain | What's Demonstrated |
|---|---|
| **Foundation** | Tenant baseline, identity types, naming and group strategy |
| **Access Control** | Least privilege, RBAC, group-based access, scoped admin |
| **Conditional Access** | Risk-based policies, MFA, session controls, exclusions done right |
| **Privileged Access** | PIM, just-in-time elevation, eligible vs. active roles |
| **Identity Governance** | Access reviews, entitlement management, lifecycle controls |
| **Identity Lifecycle** | Joiner / Mover / Leaver automation via PowerShell + Graph |
| **Hybrid Identity & SSO** | Sync considerations, federation, SAML/OIDC single sign-on |
| **Operations & Monitoring** | Audit logging, sign-in analysis, incident response runbooks |
| **Automation & IaC** | Repeatable provisioning and policy-as-code workflows |

---

## Environment Overview

| Component | Configuration |
|---|---|
| Identity Platform | Microsoft Entra ID (P2) |
| Identity Types | Cloud-only and hybrid |
| Access Model | Role-based and group-based |
| Security Controls | MFA, Conditional Access, PIM |
| Automation | PowerShell / Microsoft Graph API / Infrastructure-as-Code |
| Documentation | Markdown runbooks, decision records, validation notes |

---

## Repository Structure

Each phase represents a logical layer of enterprise IAM operations. Work through them in order, or jump to a domain.

| Phase | Folder | Focus |
|---|---|---|
| 00 | [`000-overview`](./000-overview) | Lab charter, objectives, and architecture |
| 01 | [`001-foundation`](./001-foundation) | Tenant baseline, identity and group design |
| 02 | [`0002-ACCESS-CONTROL`](./0002-ACCESS-CONTROL) | RBAC, least privilege, access models |
| 03 | [`003-Identity-Governance`](./003-Identity-Governance) | Access reviews, entitlement management, PIM |
| 04 | [`004-Operations-and-Monitoring`](./004-Operations-and-Monitoring) | Logging, auditing, incident response |
| 05 | [`005-Case-Scenario`](./005-Case-Scenario) | End-to-end real-world scenario walkthroughs |
| 06 | [`006-Hybrid-SSO`](./006-Hybrid-SSO) | Hybrid identity, federation, SAML/OIDC SSO |
| 07 | [`007-Automation-IaC`](./007-Automation-IaC) | PowerShell / Graph automation and Infrastructure-as-Code |

---

## Lab Philosophy

This is treated as a **living IAM environment**, not a one-off exercise:

- **Changes are documented** — what changed, when, and by whom
- **Decisions are justified** — every control ties back to a risk or requirement
- **Risks are identified** — assumptions and gaps are called out, not hidden
- **Controls are validated** — configuration is tested, not assumed

---

## Skills Demonstrated

`Microsoft Entra ID` · `Conditional Access` · `RBAC` · `PIM` · `Access Reviews` · `Entitlement Management` · `MFA` · `Joiner/Mover/Leaver Automation` · `PowerShell` · `Microsoft Graph API` · `Hybrid Identity` · `SAML / OIDC SSO` · `Infrastructure-as-Code` · `Audit & Monitoring` · `Incident Response` · `Zero Trust`

---

## Roadmap

- [x] Phase 1 — Foundation
- [x] Phase 2 — Access Control & Least Privilege
- [x] Phase 3 — Identity Governance (Access Reviews, PIM, Entitlement Management)
- [ ] Phase 4 — Operations & Monitoring
- [ ] Phase 5 — End-to-end Case Scenarios
- [x] Phase 6 — Hybrid Identity & SSO
- [ ] Phase 7 — Automation & Infrastructure-as-Code

---

## License

Released under the [MIT License](./LICENSE).

---

> **Connect:** [LinkedIn](https://www.linkedin.com/in/allon-ingram-0a0803226/) · [IAM Projects Portfolio](https://github.com/Ingrambtp3/IAM--PROJECTS)