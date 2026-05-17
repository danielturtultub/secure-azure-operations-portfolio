# ADR-0010: Disable soft-delete on Recovery Services Vault for the lab only

**Status:** Accepted (lab-specific override)

## Context
Soft-delete protects backup data with a 14-day grace period after stop-protection. In production this is critical. In the lab, the 14-day period prevents rapid teardown.

## Decision
For the lab vault only, disable soft-delete. Production vaults keep soft-delete enabled. Document this exception explicitly.

## Consequences
- Lab vaults can be deleted in minutes after stop-protection-with-delete-data.
- Override is a documented exception, not a default.
