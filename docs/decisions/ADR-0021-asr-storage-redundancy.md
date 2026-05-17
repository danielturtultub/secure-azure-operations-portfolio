# ADR-0021: Azure Site Recovery storage redundancy — LRS in lab, GRS in production

**Status:** Accepted

## Context
ASR replicates VM disks to a target region. The cache storage account holding replication state has a redundancy choice: LRS (cheapest), ZRS, GRS, GZRS.

## Decision
Lab uses LRS for the ASR cache storage to control cost and enable rapid teardown. Production deployments use GZRS for the cache so a regional outage doesn't impact replication state itself.

## Consequences
- LRS at ~$0.018/GB/month vs GZRS at ~$0.061/GB/month.
- LRS does not survive zonal failures of the source region; production GZRS is more resilient.
- The trade-off is documented in this ADR and the production migration path is one storage account redundancy upgrade.
