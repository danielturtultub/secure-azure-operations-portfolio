# ADR-0012: System vs user-assigned Managed Identity selection rules

**Status:** Accepted

## Context
Managed Identities come in two flavors. System-assigned MIs are tied to a specific resource. User-assigned MIs are standalone, attachable to many resources.

## Decision
- **System-assigned** when one resource needs an identity unique to it.
- **User-assigned** when multiple resources share the same access pattern.

## Consequences
- System-assigned: less management overhead, automatic cleanup, but per-resource RBAC grants.
- User-assigned: one RBAC grant covers all attached resources, but the identity exists independently.
- Federated workload identity (preview) is the future for cross-cloud and on-prem identities.
