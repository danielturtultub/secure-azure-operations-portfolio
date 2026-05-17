# ADR-0008: Disable shared key access on storage accounts

**Status:** Accepted

## Context
Storage accounts support shared key (account key, SAS) and Microsoft Entra ID (RBAC) authentication. Shared keys are full-access credentials with no per-identity attribution.

## Decision
Set `--allow-shared-key-access false` at storage account creation. All data-plane access goes through Microsoft Entra ID with role grants.

## Consequences
- Every caller needs an explicit RBAC grant.
- Audit trails identify the calling principal per operation.
- Compromised credentials revoked per-identity, not per-account.
- Tools that only support shared keys cannot be used.
