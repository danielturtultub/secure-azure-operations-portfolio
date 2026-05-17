# ADR-0001: Hub-and-spoke topology over flat single-VNet

**Status:** Accepted

## Context
The portfolio needs a network topology that supports multiple workloads, centralized identity and monitoring services, and a clear path to add VPN, Firewall, or Application Gateway services later without rearchitecting.

## Decision
Use a hub-and-spoke topology with one hub VNet and two workload spokes. Hub holds shared services and reserved subnets for Bastion, gateway, Firewall, and Application Gateway. Spokes connect to the hub via VNet peering with `allow-gateway-transit` on the hub side and `use-remote-gateways` on the spoke side.

## Consequences
- New workloads land in new spokes without touching existing spokes.
- Centralized services (DNS, monitoring egress, Bastion, Firewall) live in one place.
- Spoke-to-spoke traffic does not transit by default — requires Azure Firewall or NVA in the hub.
- Slightly more peering relationships to manage; mitigated by the custom RBAC role (VNet Peering Manager) from module 02.
