# ADR-0013: Customer-managed keys for storage encryption

**Status:** Accepted

## Context
Storage accounts encrypt at rest by default with Microsoft-managed keys. CMK shifts the encryption key into a Key Vault under customer control.

## Decision
Configure CMK on the portfolio storage account using a 2048-bit RSA key in Key Vault. Enable automatic key rotation by leaving the key version field empty.

## Consequences
- Loss of access to the KV key makes storage data unreadable. Mitigated by purge protection.
- Key rotation automatic.
- One additional RBAC grant: storage account MI requires `Key Vault Crypto Service Encryption User`.
