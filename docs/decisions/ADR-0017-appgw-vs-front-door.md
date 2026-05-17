# ADR-0017: Application Gateway WAF v2 vs Front Door for L7 protection

**Status:** Accepted

## Context
Both Application Gateway WAF v2 and Front Door provide L7 routing, TLS termination, and WAF. They overlap but are not interchangeable.

## Decision
Use both, layered. Front Door at the global edge for routing and global WAF. Application Gateway WAF v2 at the regional edge for regional WAF, SSL offload to backends, and backend health management.

## Consequences
- Two WAF rule sets to maintain, run in series — Front Door's WAF first, AppGW's WAF second.
- Cost: AppGW v2 ~$0.20/hr base + capacity units; Front Door Standard ~$35/month base.
- Defense in depth pays for itself when one WAF tier has a rule gap.
- For single-region applications, AppGW alone suffices.
- For static sites, Front Door alone suffices.
- Multi-region dynamic apps need both layers.
