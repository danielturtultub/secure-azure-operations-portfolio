# ADR-0022: Conditional Access report-only mode as deployment-safety pattern

**Status:** Accepted

## Context
Conditional Access policies enforce sign-in conditions like MFA requirements, device compliance, and named-location restrictions. A misconfigured CA policy can lock users out, including the deploying admin.

## Decision
All new Conditional Access policies are deployed in report-only state first. Sign-in logs are reviewed for what the policy would have blocked. Once verified safe, the policy is promoted to On.

## Consequences
- Catches over-broad policies before enforcement.
- Adds a review window of typically 24-72 hours before the policy is enforced.
- Break-glass accounts excluded explicitly before promotion to On.
- Pattern matches the audit-then-deny pattern from Azure Policy module 01.
- The capture proof in module 02 is a sign-in log Conditional Access tab showing report-only evaluation result.
