# ADR-0002: Tags for environment, resource groups for service domain

**Status:** Accepted

## Context
Resource groups can slice resources by environment (rg-prod, rg-dev) or by service domain (rg-network, rg-compute). Mixing both produces hybrid groupings that confuse cost reports and access boundaries.

## Decision
Resource groups slice by service domain. Environment is expressed as the `Environment` tag.

## Consequences
- Cost views remain stable as environments scale.
- An RBAC grant at RG scope grants service-domain authority.
- Per-environment access boundaries require tag-based access conditions or the Lab MG hierarchy from ADR-0003.
