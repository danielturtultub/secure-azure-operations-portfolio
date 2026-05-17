# ADR-0019: Defender for Cloud plan enablement strategy and cost discipline

**Status:** Accepted

## Context
Microsoft Defender for Cloud has multiple paid plans. Each plan adds protection for one workload class. Plans are billed independently — turning on all five plans on a populated subscription is non-trivial cost.

## Decision
Production environments enable plans matching deployed workload classes. The lab enables all five plans briefly to capture evidence (secure score before/after, JIT, malware scanning, KV alerts, ARM alerts) then reverts all paid plans to Free via the kill-switch script.

## Consequences
- Plans-on duration kept under 24 hours per evidence cycle.
- Total Defender cost across project lifetime: ~$5.
- Kill-switch script reverts all plans to Free at end of session — mandatory.
- Production teams keep their relevant plans on continuously; the lab pattern doesn't transfer to production directly.
