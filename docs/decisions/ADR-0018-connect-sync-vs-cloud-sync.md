# ADR-0018: Microsoft Entra Connect Sync vs Cloud Sync selection rules

**Status:** Accepted

## Context
Two products synchronize on-premises Active Directory to Microsoft Entra ID: Connect Sync (full-featured, Windows service on a server) and Cloud Sync (lightweight agents).

## Decision
Use Connect Sync for the portfolio's hybrid identity demonstration. Cloud Sync is documented as the alternative with selection rules.

## Consequences
- Connect Sync supports password hash sync, pass-through auth, federation, device write-back, group write-back, Exchange hybrid.
- Cloud Sync supports password hash sync, multi-forest more easily, no infrastructure server requirement, but lacks device write-back, group write-back, and Exchange hybrid scenarios.
- Decision rule: Connect Sync if Exchange hybrid is required or full feature breadth is needed; Cloud Sync if greenfield or simpler topology.
- Connect Sync's server is a single point of failure; staging mode mitigates.
