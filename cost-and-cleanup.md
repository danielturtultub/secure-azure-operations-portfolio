# Cost and cleanup

This portfolio runs on a $300 total budget across roughly 60 days. Sustained baseline runs $15–25/month. The remainder of the budget is reserved for short bursts when expensive services (Azure Firewall, Application Gateway WAF v2, VPN Gateway, Front Door, Microsoft Sentinel, full ASR replication, all Defender plans) are deployed for evidence and torn down inside the same session via an automated kill-switch script.

## Budget configuration

A monthly subscription budget is set at $100/month with three alert thresholds, evaluated independently against each subscription. The total project ceiling of $300 is tracked manually against the cumulative actual spend.

```bash
az consumption budget create \
  --budget-name budget-portfolio-monthly \
  --amount 100 \
  --category Cost \
  --time-grain Monthly \
  --start-date 2026-05-01 \
  --end-date 2026-08-31
```

Alert thresholds: 50% (early warning), 80% (decision point — pause non-essential builds), 100% (kill-switch — run the teardown script for all build-and-tear-down resources).

## Sustained baseline (always on)

Combined cost target: $15–25/month per subscription.

| Resource | Type | Estimated monthly cost | Notes |
|---|---|---|---|
| Resource groups (10) | RG | $0 | Empty RGs are free |
| All VNets, peerings, NSGs, ASGs | Network | $0 | Free at lab volumes |
| `law-portfolio-lab-eastus-01` | Log Analytics | $1–4 | 0.5 GB/day cap |
| `kv-portfolio-lab-eus-XX` | Key Vault | <$0.10 | Operations billed |
| `stportfoliolabeusXX` | Storage | <$1 | Standard LRS GPv2 |
| `aa-portfolio-lab-eus-01` | Automation Account | $0 | First 500 min/month free |
| Action group | Azure Monitor | $0 | Email free |
| 1–3 metric alerts | Azure Monitor | <$0.50 | $0.10/alert/month |
| 1 log search alert | Azure Monitor | $1.50 | Per Microsoft pricing |
| Tags | — | $0 | |
| Custom RBAC roles | — | $0 | |
| Management group | — | $0 | |
| Second subscription (empty) | — | $0 | Free if no resources |

The sustained baseline is intentionally lean. Everything expensive is build-and-tear-down.

## Build-then-tear-down catalog

Each entry includes within-session cost and the cleanup commands. The `scripts/kill-switch.sh` script (in module 09) tears down all of these in one command at end of session.

### Azure Bastion Standard SKU

**Cost:** ~$5/day Standard SKU. Standard adds shareable link, native client (`az network bastion`), and IP-based connection.

**Lifecycle:** Deploy at start of session, capture connection screenshots, tear down before logging off.

```bash
# Deploy
az network public-ip create -g rg-network-hub-lab-eastus-01 -n pip-bastion-lab-eastus-01 --sku Standard
az network bastion create -g rg-network-hub-lab-eastus-01 -n bastion-hub-lab-eastus-01 \
  --public-ip-address pip-bastion-lab-eastus-01 --vnet-name vnet-hub-lab-eastus-01 \
  --location eastus --sku Standard --enable-tunneling true --enable-shareable-link true

# Tear down
az network bastion delete -g rg-network-hub-lab-eastus-01 -n bastion-hub-lab-eastus-01
az network public-ip delete -g rg-network-hub-lab-eastus-01 -n pip-bastion-lab-eastus-01
```

### Azure Firewall Standard

**Cost:** ~$1.25/hr (~$30/day). Most expensive single service in the portfolio.

**Lifecycle:** Deploy for one session lasting 2–4 hours. Capture network rule, application rule with FQDN filtering, NAT rule. Tear down within same session.

```bash
# Tear down
az network firewall delete -g rg-network-hub-lab-eastus-01 -n fw-hub-lab-eastus-01
az network public-ip delete -g rg-network-hub-lab-eastus-01 -n pip-fw-lab-eastus-01
```

### Application Gateway WAF v2

**Cost:** ~$0.20/hr base + capacity units. ~$10 for a half-day deployment.

**Lifecycle:** Deploy with one backend pool, one HTTP listener, WAF in Prevention mode. Capture the WAF blocking a simulated SQL injection. Tear down same session.

```bash
# Tear down
az network application-gateway delete -g rg-network-hub-lab-eastus-01 -n agw-app-lab-eastus-01
az network public-ip delete -g rg-network-hub-lab-eastus-01 -n pip-agw-lab-eastus-01
```

### VPN Gateway Basic

**Cost:** ~$0.04/hr (~$1/day). Affordable for a one-day demonstration.

**Lifecycle:** Deploy in GatewaySubnet for one session. Capture deployed state, verify peering gateway-transit flag works, tear down same day.

### Front Door Standard

**Cost:** ~$35/month base. The lab keeps it for 2–3 days max during week 4.

**Lifecycle:** Deploy with one origin, one routing rule. Capture routing decision in logs. Tear down within 72 hours.

### Internal Load Balancer with backend VMs

**Cost:** Standard LB ~$0.025/hr; backend VMs (2× B1s) ~$0.024/hr. ~$0.50/day.

**Lifecycle:** Deploy in module 03 to demonstrate health probes and load-balancing rules. Tear down within 24 hours.

### Recovery Services Vault with one VM backed up

**Cost:** Vault free; first backup ~$10/month protected instance + storage.

**Lifecycle:** Deploy with soft-delete disabled (lab override; document in ADR-0010). Back up one VM, demonstrate file-level and full-VM restore, stop protection with delete-data, then delete vault.

### Full ASR replication for one VM

**Cost:** ~$25/month per replicated instance + replication storage (~$5).

**Lifecycle:** Deploy ASR for one VM, capture replication-healthy state, run test failover, capture failed-over VM in target region, run failback, tear down replication.

```bash
# Disable replication, then delete the vault
az site-recovery replicated-item delete -g $RG_B --vault-name $RSV_NAME --name <replicated-item>
```

### Microsoft Sentinel

**Cost:** ~$2.30/GB on top of LA ingestion (~$1–3 for a few-day enablement).

**Lifecycle:** Enable Sentinel on the LA workspace, configure one connector (Azure Activity), create one analytics rule (impossible-travel sign-ins), capture an incident, disable Sentinel.

### Defender for Cloud all major plans

**Cost:** ~$15/server/month for Defender for Servers Plan 2; Defender for Storage ~$0.02/10K transactions; Defender for Key Vault ~$2/10K operations; Defender for Resource Manager ~$4/sub/month; Defender for SQL ~$15/server/month. **All five plans enabled briefly: ~$5 for the demonstration window.**

**Lifecycle:** Enable all five plans, capture secure score after each enablement, capture coverage in Defender → Environment Settings, run JIT demonstration. **Disable all five plans within 24 hours.**

```bash
# Disable all paid plans
for plan in VirtualMachines StorageAccounts KeyVaults Arm SqlServers; do
  az security pricing create -n $plan --tier Free
done
```

### Test VMs

**Cost:** Standard_B1s ~$0.012/hr. Negligible if torn down same session.

```bash
# Standard VM cleanup with disk and NIC sweep
VM=vm-test-lab-eus-01
RG=rg-compute-lab-eastus-01
az vm delete -g $RG -n $VM --yes
az disk list -g $RG --query "[?managedBy==null].id" -o tsv | xargs -r -n1 az disk delete --yes --ids
az network nic list -g $RG --query "[?virtualMachine==null].id" -o tsv | xargs -r -n1 az network nic delete --ids
```

## The kill-switch script

`scripts/kill-switch.sh` runs at end of every session that touched build-and-tear-down resources. It deletes everything in the catalog above in correct dependency order, then runs the orphan audit.

```bash
#!/usr/bin/env bash
set -euo pipefail

RG_NET=rg-network-hub-lab-eastus-01
RG_C=rg-compute-lab-eastus-01
RG_B=rg-backup-lab-eastus-01

echo "=== Tearing down expensive services ==="

az network firewall delete -g $RG_NET -n fw-hub-lab-eastus-01 2>/dev/null && echo "  Firewall deleted" || echo "  Firewall not present"
az network application-gateway delete -g $RG_NET -n agw-app-lab-eastus-01 2>/dev/null && echo "  AppGW deleted" || echo "  AppGW not present"
az network vnet-gateway delete -g $RG_NET -n vng-hub-lab-eastus-01 2>/dev/null && echo "  VPN GW deleted" || echo "  VPN GW not present"
az network front-door delete -g $RG_NET -n fd-portfolio-lab 2>/dev/null && echo "  Front Door deleted" || echo "  Front Door not present"
az network bastion delete -g $RG_NET -n bastion-hub-lab-eastus-01 2>/dev/null && echo "  Bastion deleted" || echo "  Bastion not present"
az network lb delete -g $RG_NET -n ilb-app-lab-eastus-01 2>/dev/null && echo "  ILB deleted" || echo "  ILB not present"

echo ""
echo "=== Tearing down test VMs ==="
az vm list -g $RG_C --query "[?tags.ExpiryDate].id" -o tsv | xargs -r -n1 az vm delete --yes --ids

echo ""
echo "=== Disabling Defender paid plans ==="
for plan in VirtualMachines StorageAccounts KeyVaults Arm SqlServers; do
  az security pricing create -n $plan --tier Free 2>/dev/null && echo "  $plan reverted to Free" || true
done

echo ""
echo "=== Sweeping orphans ==="
az disk list --query "[?managedBy==null].id" -o tsv | xargs -r -n1 az disk delete --yes --ids
az network nic list --query "[?virtualMachine==null].id" -o tsv | xargs -r -n1 az network nic delete --ids
az network public-ip list --query "[?ipConfiguration==null].id" -o tsv | xargs -r -n1 az network public-ip delete --ids

echo ""
echo "=== Done. Cost guard active. ==="
```

Run this at the end of any session that touched anything in the build-and-tear-down catalog. It is idempotent — running it on a clean baseline does nothing harmful.

## Daily orphan-resource audit

Untracked resources are the primary cause of unexpected lab spend. `scripts/cleanup-orphans.sh` (also in module 09) catches the most common offenders.

```bash
echo "=== Unattached managed disks ==="
az disk list --query "[?managedBy==null].[name,resourceGroup,diskSizeGb,sku.name]" -o table

echo "=== Unattached public IPs ==="
az network public-ip list --query "[?ipConfiguration==null].[name,resourceGroup,sku.name]" -o table

echo "=== Unattached network interfaces ==="
az network nic list --query "[?virtualMachine==null].[name,resourceGroup]" -o table

echo "=== Resources past ExpiryDate ==="
TODAY=$(date +%Y-%m-%d)
az resource list --query "[?tags.ExpiryDate != null && tags.ExpiryDate < '$TODAY'].[name,type,resourceGroup,tags.ExpiryDate]" -o table
```

Run weekly minimum. Anything stale is either deleted or has its `ExpiryDate` extended with documented reason.

## End-of-portfolio teardown

When you decide the portfolio is done — exam passed, job landed, moved on — the full teardown is one command per resource group, in dependency order.

```bash
# Run kill-switch first to clear expensive transient resources
bash scripts/kill-switch.sh

# Then delete RGs in dependency order
for rg in rg-iac-lab-eastus-01 rg-compute-lab-eastus-01 rg-storage-lab-eastus-01 \
          rg-monitor-lab-eastus-01 rg-backup-lab-eastus-01 rg-security-lab-eastus-01 \
          rg-hybrid-lab-eastus-01 rg-network-hub-lab-eastus-01 \
          rg-identity-lab-eastus-01 rg-platform-lab-eastus-01; do
  echo "Deleting $rg"
  az group delete --name $rg --yes --no-wait
done

# Wait, then verify
sleep 600
az group list -o table | grep lab
```

For RG deletion failures due to locks, list and remove first:

```bash
az lock list -g <rg> -o table
az lock delete --name <lock-name> -g <rg>
```

## Cost reflection per module

Each module README ends with a cost summary in this format:

```
**Cost:** $X spent on this module. Sustained add: $Y/month.
```

These feed into a single capstone roll-up in `10-final-capstone/README.md` so the total portfolio cost can be reviewed against the $300 budget.
