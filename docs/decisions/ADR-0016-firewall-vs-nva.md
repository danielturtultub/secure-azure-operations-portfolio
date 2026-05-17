# ADR-0016: Azure Firewall in hub vs per-spoke NVAs

**Status:** Accepted

## Context
Centralized egress filtering can be done with Azure Firewall in the hub or with third-party network virtual appliances (Palo Alto, Fortinet, Check Point) deployed per-spoke or in the hub.

## Decision
Deploy Azure Firewall Standard in the hub. Spoke route tables direct 0.0.0.0/0 to the Firewall private IP. Firewall does network rules, application rules with FQDN filtering, and NAT.

## Consequences
- Platform-managed, no patching, integrated with Azure Policy and Microsoft Sentinel.
- ~$1.25/hr operational cost — hence build-and-tear-down in this lab.
- NVA-specific features (deep packet inspection, vendor IPS signatures, custom VPN protocols) not available; mitigated by Firewall Premium tier where required.
- Deployment is in module 03; teardown is via the kill-switch script.
