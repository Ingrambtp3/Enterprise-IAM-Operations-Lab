# Log Export and Retention

## Purpose
Define how identity-related logs are exported, retained, and accessed to support
security monitoring, investigations, governance validation, and audit requirements.

## Log Destinations
Identity logs are exported to centralized storage for analysis and retention.

Primary destinations may include:
- Log Analytics workspace
- SIEM platform (current or future)
- Secure archival storage (where required)

Logs are not relied on solely in the Entra portal for long-term visibility.

## Exported Log Types
The following log categories are exported:
- Sign-in logs
- Audit logs
- Privileged access activity logs

Export ensures logs remain available beyond default portal retention limits.

## Retention Strategy
- Retention duration is defined based on risk, audit, and operational needs
- Identity and privileged activity logs are retained longer than standard sign-in logs
- Retention decisions balance cost with investigative value

Retention targets may differ for:
- Standard user activity
- Privileged activity
- Guest access activity

## Access to Logs
- Log access is restricted to security and IAM operators
- Read-only access is preferred for investigations and audits
- Access to modify logging configuration is tightly controlled

## Governance Alignment
- Logs support access reviews and lifecycle enforcement
- Privileged access logs validate elevation governance
- Guest activity logs support external identity oversight

## Failure Handling
- Log export failures are treated as visibility risks
- Gaps in logging are investigated and documented
- Logging configuration changes are reviewed and approved

## Review and Maintenance
- Log export and retention settings are reviewed periodically
- Changes to retention strategy are documented
- Log usefulness is evaluated against operational needs
