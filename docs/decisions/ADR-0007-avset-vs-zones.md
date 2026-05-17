# ADR-0007: Availability Zones for new workloads, AvSet for legacy continuity

**Status:** Accepted

## Context
Availability Sets and Availability Zones provide HA primitives with different SLA boundaries. AvSet protects within a single datacenter (99.95% SLA). Zones protect across physically separated datacenters within a region (99.99% SLA).

## Decision
New workloads use Availability Zones. Existing AvSet-based workloads remain on AvSet for continuity.

## Consequences
- Zone-redundant SKUs cost ~10% more.
- Cross-zone traffic incurs minor data transfer.
- 99.99% beats 99.95%.
