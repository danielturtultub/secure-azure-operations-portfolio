# ADR-0006: Hub-and-spoke detailed cost and complexity tradeoff

**Status:** Accepted

## Context
This ADR extends ADR-0001 with the cost-and-complexity comparison.

## Decision
Hub-and-spoke pays for itself starting at three workloads sharing common services. Below three, a flat VNet is simpler. The portfolio has two spokes plus design-room for more.

## Consequences
- Operational complexity: ~1.5x flat VNet.
- Cost: peerings free; data transfer charges negligible at lab volumes.
- Future migration cost from flat to hub-and-spoke is high (re-IPing); starting hub-and-spoke avoids that future cost.
