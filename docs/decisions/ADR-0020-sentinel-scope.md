# ADR-0020: Microsoft Sentinel — enable briefly for evidence vs sustained operations

**Status:** Accepted

## Context
Sentinel provides cloud-native SIEM/SOAR on top of a Log Analytics workspace. It adds ~$2.30/GB on top of standard ingestion plus the cost of running playbooks and incident workflows.

## Decision
Enable Sentinel on the workspace briefly during module 06. Configure one data connector (Azure Activity), author one analytics rule (impossible-travel sign-ins), capture an incident, then disable Sentinel. Production deployments would keep it enabled with full data connector coverage.

## Consequences
- Sentinel-on duration: ~24-48 hours.
- Sentinel cost: ~$2 for the demonstration window at lab data volumes.
- Detection-engineering depth in this lab is intentionally light — the focus is "what is Sentinel" and "how does it integrate" rather than full detection rule library authoring.
- Cost discipline is in cost-and-cleanup.md.
