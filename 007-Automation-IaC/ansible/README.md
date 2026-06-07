# 🤖 007 — Automation/IaC | Ansible Offboarding Playbook 🤖

**Phase:** 7 — Automation & IaC  **Tenant:** ByteKage (ByteKage.onmicrosoft.com)  **Tool:** Ansible  **Target:** Microsoft Entra ID via Graph API  **Status:** ✅ Configured and tested (idempotency verified)  **Date:** 2026-06-06

## What This Is
An Ansible playbook that automates employee offboarding against Entra ID. When a user leaves, it disables their account, strips every group membership, and writes an audit log the same way, every time.

This is the configuration-management companion to the Terraform work in this phase. Terraform provisions identity infrastructure (creates users and groups). Ansible configures and acts on what already exists (disables a user, removes memberships, runs the offboarding sequence). Provision vs. configure two different jobs. It also operationalizes the Phase 4 "Account disable (Leaver)" runbook.

## What It Does
1. Gets a Graph access token from the local Azure CLI session
2. Looks up the leaver by UPN and reads the real accountEnabled state
3. Reads the leaver's group memberships
4. Disables the account — only if it is currently enabled
5. Removes the leaver from each group
6. Writes an audit log with timestamp, UPN, object ID, before-state, and action taken

## Idempotency — the key concept
Safe to run repeatedly; only acts when there is something to do. Run 1: account enabled, so disabled it and removed the group. Run 2: already disabled, so the disable task skipped and removal skipped. That skip-when-already-done behavior is idempotency — the difference between real automation and a script that blindly redoes work.

## Authentication note (honest)
This playbook borrows the authenticated Azure CLI session to get a Graph token at runtime, keeping secrets out of the repo. In production the correct pattern is app-only credentials (a service principal with least-privileged Graph permissions), not a person's delegated CLI session. The delegated session is fine for a lab; app-only is for unattended production automation.

## Reporting nuance (honest)
The actions use Ansible's uri module to call Graph directly. The uri module reports whether the HTTP call succeeded, not whether tenant state changed, so changed_when conditions are used to make the run summary report changed only when a real change occurred.

## Status
✅ Configured and tested against a dedicated throwaway test account. Disable and group-removal confirmed directly in Entra. Idempotency proven across two runs.

##Screenshots 📸
<img width="1374" height="632" alt="Screenshot 2026-06-07 at 1 09 22 PM" src="https://github.com/user-attachments/assets/804726e8-f0c9-4e53-bf47-b233cef271f0" />


## Related Phases
- Operationalizes: Phase 4 "Account disable (Leaver)" runbook
- Pairs with: Terraform (this phase) — provision vs. configure
- Builds on: Phase 1 (users/groups), Phase 2 (access model)
