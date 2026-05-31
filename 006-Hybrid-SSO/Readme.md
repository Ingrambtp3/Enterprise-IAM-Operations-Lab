#  🛡️006 — Hybrid SSO | Okta ↔ Entra ID SAML Federation 🛡️
 
**Phase:** 6 — Hybrid SSO
**Tenant:** ByteKage (ByteKage.onmicrosoft.com)
**IdP:** Okta (integrator-xxxxxxx.okta.com)
**Protocol:** SAML 2.0
**Status:** ✅ Configured and verified
**Date:** 2026-05-31
 
---
 
## What This Is 🤔
 
This phase configures Okta as an external SAML Identity Provider (IdP) federated
into the ByteKage Entra ID tenant. Entra ID acts as the Service Provider (SP).
 
When federation is active, users can authenticate through Okta and access
Entra ID resources — two separate identity platforms trusting each other
through a SAML assertion.
 
This mirrors real enterprise environments where organizations operate multiple
IdPs simultaneously — through acquisition, legacy systems, or multi-platform
standardization.
 
---
 
## Architecture 🛠️
 
```
User → Okta (authenticates) → SAML Assertion → Entra ID (trusts and grants access)
  IdP: Okta                    Protocol: SAML 2.0         SP: ByteKage Entra ID
```
 
---
 
## What SAML Federation Actually Does 🤝
 
When a user attempts to access an Entra ID resource:
 
1. Entra ID checks the user's domain against configured federation rules
2. If the domain matches a federated IdP, Entra ID redirects to Okta
3. Okta authenticates the user (password, MFA, whatever Okta policy requires)
4. Okta issues a signed SAML assertion back to Entra ID
5. Entra ID validates the assertion signature against Okta's certificate
6. If valid, Entra ID grants access — trusting what Okta says about the user
 🚨The key concept: Entra ID never sees the user's password. It only sees the signed
assertion from Okta. The trust is in the certificate, not the credential. 🚨
 
---
 
## Configuration — Okta Side ⚡️
 
**App created:** Bytekage-Entra-SAML
**App type:** SAML 2.0
**Status:** Active
 
| Setting | Value |
|---|---|
| Single Sign-On URL | `https://login.microsoftonline.com/1f30af42-xxxx-xxxx-xxxx-xxxxxxxxxxxx/saml2` |
| Audience URI (SP Entity ID) | `urn:federation:MicrosoftOnline` |
| Name ID format | EmailAddress |
| Application username | Email |
| Signing certificate | SHA-2, Active, expires 2036-05-31 |
 
---
 
## Configuration — Entra ID Side
 
**IdP name:** Okta-Bytekage-Federation
**Protocol:** SAML
**Domain:** integrator-xxxxxxx.okta.com
**Certificate expiration:** 2036-05-31
**Configured via:** External Identities → All identity providers → Custom
 
| Setting | Value |
|---|---|
| Display name | Okta-Bytekage-Federation |
| Identity provider protocol | SAML |
| Domain of federating IdP | integrator-xxxxxx.okta.com |
| Metadata populated via | Parsed metadata XML file |
| Certificate valid until | 5/31/2036 |
 
---
 
## Key Concepts Demonstrated
 
**SAML Trust is certificate-based**
The federation works because Entra ID has Okta's public signing certificate.
When Okta sends an assertion, Entra ID validates the signature against that certificate.
If the signature doesn't match, access is denied — regardless of what the assertion claims.
 
**IdP vs SP roles**
- Okta = Identity Provider — authenticates the user, issues the assertion
- Entra ID = Service Provider — consumes the assertion, grants access to resources
These roles are not fixed — in other configurations Entra ID can act as the IdP.
**Domain-based routing**
Federation is triggered by domain. When Entra ID sees a user from a federated domain,
it redirects to the configured IdP automatically. The user doesn't choose which IdP —
the domain routes them.
 
**Certificate lifecycle is an operational responsibility**
The Okta signing certificate expires 2036-05-31. In a production environment,
certificate expiration without rotation causes a complete authentication outage
for all federated users. This must be tracked and rotated before expiration.
 
---
 
## 📸 Screenshots 📸
 <img width="1080" height="471" alt="Screenshot 2026-05-31 at 6 15 52 PM" src="https://github.com/user-attachments/assets/614ed99a-97ad-4ca0-8914-b9706ce1a91f" />
<img width="1134" height="525" alt="Screenshot 2026-05-31 at 6 17 20 PM" src="https://github.com/user-attachments/assets/e5cdeae5-775e-4099-a925-bb753677f6f5" />


---
 
## Status 🕵🏾
 
✅ Complete — SAML trust configured on both sides. Okta app Active.
Entra ID custom IdP created with valid certificate through 2036.
 
## Related Phases
 
- Depends on: Phase 1 (Foundation) — tenant and domain structure
- Depends on: Phase 2 (Access Control) — CA policies apply to federated users
- Feeds into: Phase 5 (Case Scenarios) — federated identity scenario documentation
 
