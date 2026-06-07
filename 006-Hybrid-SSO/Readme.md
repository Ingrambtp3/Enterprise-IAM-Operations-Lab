# 🛡️ 006 — Hybrid SSO | Entra ID ↔ Okta Federation (SAML 2.0 + OIDC) 🛡️
 
**Phase:** 6 — Hybrid SSO  **Tenant:** ByteKage (ByteKage.onmicrosoft.com)  **Platforms:** Microsoft Entra ID + Okta (integrator-xxxxxxx.okta.com)  **Protocols:** SAML 2.0 and OpenID Connect (OIDC) on OAuth 2.0  **Status:** ✅ Configured  **Dates:** SAML 2026-05-31 · OIDC 2026-06-05
 
---
 
## What This Phase Is 🤔
 
This phase federates two separate identity platforms — **Microsoft Entra ID** and **Okta** — so they trust each other's authentication. It does this **two ways, with both major federation protocols**, in **opposite directions**:
 
| Artifact | Protocol | IdP (authenticates) | Relying Party / SP (trusts) |
|---|---|---|---|
| **Artifact 1 — SAML federation** | SAML 2.0 | **Okta** | **Entra ID** |
| **Artifact 2 — OIDC federation** | OIDC / OAuth 2.0 | **Entra ID** | **Okta** |
 
The goal isn't to pick a winner. It's to build both, understand the mechanics of each, and be able to say *when you'd reach for which* — because real environments run both at the same time.
 
---
 
## Federation, Plainly 🧠
 
Two clubs agree to trust each other's hand stamps.
 
- The **Identity Provider (IdP)** is the bouncer — it checks your ID and vouches for who you are.
- The **Service Provider / Relying Party (SP / RP)** is the other venue — it sees the stamp and lets you in without re-checking, because it trusts the bouncer.
**Federation** is just "two platforms trusting each other's proof of identity." Both SAML and OIDC are federation — they're two different *kinds of stamp*. The critical property both share: **the SP never sees the user's password.** It only ever sees a signed proof from the IdP. The trust lives in the signature, not the credential.
 
This mirrors real enterprise environments where organizations run multiple IdPs at once — through acquisition, legacy systems, partner access, or multi-platform standardization.
 
---
 
## Why Both Protocols — and When to Use Each ⚖️
 
Federation isn't "SAML vs OIDC." **OIDC *is* federation** — it's just built on a newer foundation (JSON/REST + OAuth 2.0) instead of XML. So the real question is never "which is modern," it's "which fits this environment."
 
| | **SAML 2.0** | **OpenID Connect (OIDC)** |
|---|---|---|
| Released | 2005 | 2014 |
| Built on | XML | JSON / REST, on top of OAuth 2.0 |
| Identity token | SAML Assertion (XML) | ID Token (JWT) |
| Transport | Browser POST / redirect bindings | HTTP + JSON, bearer tokens |
| Key handling | Often **manual** certificate rotation | Keys rotate, **automated** via JWKS discovery |
| Best fit | Enterprise web SSO, legacy apps, cross-org B2B | Modern apps, SPAs, mobile, APIs |
| Status | Entrenched, **not deprecated** | Default for new development |
 
**When SAML wins 🏛️** — at the **edges** of your identity perimeter. Cross-org B2B access where you can't sync a partner's users into your directory. Legacy on-prem apps that only speak SAML/ADFS. Education federations like InCommon. It's situational, not dead — and for Okta→Entra workforce federation it's the stable, natively supported path.
 
**When OIDC wins 🚀** — for **modern application authentication**. Single-page apps, mobile, APIs — anywhere XML and browser POST bindings are awkward and JSON tokens fit naturally. It's the default for anything built today.
 
**The honest nuance on "OIDC removes certificate overhead":** not quite. OIDC does **not eliminate** key rotation — the signing keys still rotate. The difference is OIDC publishes them at a discovery endpoint (`jwks_uri`), so the relying party fetches new keys **automatically** instead of an admin pasting a fresh certificate by hand. The burden is *automated*, not *removed*.
 
**Bridge-and-boundary:** federation earns its place at the edges of the identity perimeter, not the core. The protocol you reach for depends on the environment.
 
---
 
## OAuth 2.0 vs OIDC — keep these straight ⚙️
 
These get conflated constantly:
 
- **OAuth 2.0 = authorization.** Grants an app delegated permission to access a resource ("this app may read your profile"). Says nothing about *who* the user is.
- **OIDC = authentication.** An identity layer on top of OAuth 2.0. Adds the **ID Token (JWT)** that proves *who the user is*.
OAuth answers "what is this app allowed to do." OIDC answers "who is this user." Pure OAuth issues only access/refresh tokens — no identity. The ID Token is the piece that makes OIDC an authentication protocol.
 
---
---
 
# 🤝 Artifact 1 — SAML 2.0 Federation (Okta = IdP, Entra = SP)
 
**Status:** ✅ Configured and verified · **Date:** 2026-05-31
 
Okta configured as an external SAML Identity Provider federated into the ByteKage Entra ID tenant. Entra ID acts as the Service Provider. Users authenticate through Okta and access Entra ID resources — two platforms trusting each other through a signed SAML assertion.
 
## Architecture 🛠️
 
```
User → Okta (authenticates) → SAML Assertion → Entra ID (trusts and grants access)
  IdP: Okta                    Protocol: SAML 2.0         SP: ByteKage Entra ID
```
 
## What SAML Federation Actually Does
 
When a user attempts to access an Entra ID resource:
 
1. Entra ID checks the user's domain against configured federation rules
2. If the domain matches a federated IdP, Entra ID redirects to Okta
3. Okta authenticates the user (password, MFA, whatever Okta policy requires)
4. Okta issues a signed SAML assertion back to Entra ID
5. Entra ID validates the assertion signature against Okta's certificate
6. If valid, Entra ID grants access — trusting what Okta says about the user
🚨 **Key concept:** Entra ID never sees the user's password. It only sees the signed assertion from Okta. The trust is in the certificate, not the credential. 🚨
 
## Configuration — Okta Side ⚡️
 
App created: **Bytekage-Entra-SAML**  ·  App type: SAML 2.0  ·  Status: Active
 
| Setting | Value |
|---|---|
| Single Sign-On URL | https://login.microsoftonline.com/1f30af42-xxxx-xxxx-xxxx-xxxxxxxxxxxx/saml2 |
| Audience URI (SP Entity ID) | urn:federation:MicrosoftOnline |
| Name ID format | EmailAddress |
| Application username | Email |
| Signing certificate | SHA-2, Active, expires 2036-05-31 |
 
## Configuration — Entra ID Side
 
IdP name: **Okta-Bytekage-Federation**  ·  Protocol: SAML  ·  Configured via: External Identities → All identity providers → Custom
 
| Setting | Value |
|---|---|
| Display name | Okta-Bytekage-Federation |
| Identity provider protocol | SAML |
| Domain of federating IdP | integrator-xxxxxxx.okta.com |
| Metadata populated via | Parsed metadata XML file |
| Certificate valid until | 2036-05-31 |
 
## Key Concepts Demonstrated
 
**SAML trust is certificate-based** — Entra ID holds Okta's public signing certificate. When Okta sends an assertion, Entra validates the signature against it. Wrong signature → access denied, no matter what the assertion claims.
 
**IdP vs SP roles** — Okta = Identity Provider (authenticates, issues the assertion); Entra ID = Service Provider (consumes it, grants access). These roles are not fixed — see Artifact 2, where they flip.
 
**Domain-based routing** — Federation is triggered by domain. When Entra sees a user from a federated domain, it redirects to the configured IdP automatically. The user doesn't choose — the domain routes them.
 
**Certificate lifecycle is an operational responsibility** — The Okta signing certificate expires **2036-05-31**. In production, an expired certificate without rotation causes a complete authentication outage for all federated users. It must be tracked and rotated before expiry. *(Contrast this with OIDC's automated JWKS key pickup in Artifact 2 — this is the single sharpest comparison in the whole phase.)*

 
---
---
 
# 🤝 Artifact 2 — OIDC / OAuth 2.0 Federation (Entra = IdP, Okta = Relying Party)
 
**Status:** ✅ Configured · **Date:** 2026-06-05
 
Entra ID registered as an external **OpenID Connect** Identity Provider for Okta. Okta acts as the relying party. Same two platforms as Artifact 1 — **opposite direction, modern protocol**. Users authenticate through Entra ID and Okta trusts the signed ID Token (JWT) it issues.
 
**Why this direction:** Entra ID's native external-IdP federation for a workforce tenant is built around SAML / WS-Fed and does not natively accept Okta as a general-purpose OIDC sign-in IdP. Entra → Okta over OIDC, however, is a fully supported path — so this artifact is built in the direction that actually works, rather than forcing an unsupported config.
 
## Architecture 🛠️
 
```
User → Okta (relying party) → redirect → Entra ID (authenticates) → ID Token (JWT) → Okta (validates, grants access)
  SP/RP: Okta                              IdP: Entra ID            Protocol: OIDC / OAuth 2.0
```
 
## What OIDC Federation Actually Does
 
When a user signs in through Okta routed to Entra:
 
1. Okta redirects the user to Entra's `/authorize` endpoint with client_id, redirect_uri, `response_type=code`, `scope=openid profile email`, state, and nonce
2. Entra authenticates the user (password, MFA, Conditional Access — whatever Entra policy requires)
3. Entra redirects back to Okta's callback with a short-lived **authorization code**
4. Okta exchanges that code at Entra's `/token` endpoint — sending its client ID and client secret — for tokens
5. Entra returns an **ID Token (JWT)**, an Access Token, and optionally a Refresh Token
6. Okta validates the ID Token signature against Entra's published keys (`jwks_uri`), and checks issuer, audience, and expiry
7. If valid, Okta establishes the session. If no matching Okta user exists, JIT provisioning creates one
🚨 **Key concept:** Okta never sees the user's password. It only sees the signed ID Token from Entra — and the tokens never ride the browser redirect, only a short-lived code does. The trust is in the signature, validated against Entra's JWKS keys. 🚨
 
## Configuration — Entra ID Side (the IdP) ⚡️
 
App created: **Okta-OIDC-RelyingParty**  ·  App type: App registration (single tenant)  ·  Status: Active
 
| Setting | Value |
|---|---|
| Application (client) ID | 5bddcf28-xxxx-xxxx-xxxx-xxxxxxxxxxxx |
| Account types | Accounts in this directory only (single tenant) |
| Client authentication | Client secret (created, stored securely) |
| Redirect URI (Web) | https://integrator-xxxxxxx.okta.com/oauth2/v1/authorize/callback |
 
## Configuration — Okta Side (the relying party)
 
IdP name: **Entra-OIDC-Idp**  ·  IdP type: OpenID Connect IdP  ·  Configured via: Security → Identity Providers → Add → OpenID Connect IdP
 
| Setting | Value |
|---|---|
| Display name | Entra-OIDC-Idp |
| IdP usage | SSO only |
| Scopes | openid, profile, email |
| Authentication type | Client secret |
| PKCE | Not enabled (confidential web client) |
| IdP username | idpuser.email |
| Account linking | JIT — create new user if no match |
 
### Endpoints (from Entra's OIDC discovery document)
 
| Endpoint | Value |
|---|---|
| Issuer | https://login.microsoftonline.com/1f30af42-xxxx-.../v2.0 |
| Authorization | https://login.microsoftonline.com/1f30af42-xxxx-.../oauth2/v2.0/authorize |
| Token | https://login.microsoftonline.com/1f30af42-xxxx-.../oauth2/v2.0/token |
| JWKS | https://login.microsoftonline.com/1f30af42-xxxx-.../discovery/v2.0/keys |
| Userinfo | https://graph.microsoft.com/oidc/userinfo |
 
Discovery document confirmed: ID Tokens signed with **RS256**, the **authorization code** flow available, scopes `openid profile email` (plus `offline_access` for refresh tokens) supported.
 
## Key Concepts Demonstrated
 
**OIDC trust is signature-based, validated via JWKS** — Okta fetches Entra's public signing keys from the `jwks_uri` in Entra's discovery document and validates every ID Token against them. Wrong signature → access denied.
 
**Key rotation is automated, not eliminated** — The precise version of the "OIDC removes certificate overhead" claim. Keys still rotate; OIDC just automates the pickup through discovery. (Compare to Artifact 1's manual cert lifecycle — same operational need, automated solution.)
 
**IdP vs RP roles are not fixed** — Here Entra = IdP, Okta = relying party. In Artifact 1 those roles are reversed. The same two platforms play either role depending on the integration.
 
**The authorization code flow protects the tokens** — Only a short-lived code rides the browser redirect; tokens are retrieved server-to-server, authenticated by the client secret. PKCE provides equivalent protection for *public* clients (SPAs, mobile) that can't safely hold a secret — not needed here for a confidential web client.
 
**JIT provisioning** — With no pre-existing Okta user, Just-In-Time provisioning creates the account from the ID Token claims on first sign-in.
 
## 📸 OIDC Screenshots 📸
 
> Sensitive identifiers (tenant ID, client ID, IdP ID, Okta org subdomain) are redacted. The client secret is never displayed.
 
**1. Entra ID OIDC endpoints** — the discovery endpoints used to configure Okta.
 

<img width="1434" height="1653" alt="01-entra-oidc-endpoints" src="https://github.com/user-attachments/assets/6fa380a2-64bb-4a6d-a47c-b528d7066cff" />

 
**2. Okta OIDC IdP — Active, with summary**
 

<img width="2119" height="1772" alt="02-okta-idp-active-summary" src="https://github.com/user-attachments/assets/6b40c937-c327-4db6-898e-a0e6ac6cdcf7" />

 
**3. Okta IdP endpoints and JIT settings**
 

<img width="2076" height="1593" alt="03-okta-idp-endpoints-jit" src="https://github.com/user-attachments/assets/46d78abb-0f3f-4338-b371-1ea71575e320" />

 
**4. Entra redirect URI saved** — Okta callback registered back in Entra, closing the trust loop.
 

<img width="2292" height="1240" alt="04-entra-redirect-uri-saved" src="https://github.com/user-attachments/assets/e82a1b57-f304-46be-b0ca-bebcf32a2fff" />

 
---
---
 
## 🕵🏾 Phase Status
 
✅ **Configured** — Both federation trusts stood up and documented:
- **SAML:** Okta app Active; Entra custom IdP created with valid certificate through 2036.
- **OIDC:** Entra app registration active with client secret; Okta OIDC IdP Active with all endpoints wired to the ByteKage tenant and JIT provisioning enabled.
## Related Phases
 
- **Depends on:** Phase 1 (Foundation) — tenant and domain structure
- **Depends on:** Phase 2 (Access Control) — Conditional Access policies apply to federated users / at Entra authentication
- **Feeds into:** Phase 5 (Case Scenarios) — federated identity scenarios (Scenario 06: SAML SSO via Okta)
