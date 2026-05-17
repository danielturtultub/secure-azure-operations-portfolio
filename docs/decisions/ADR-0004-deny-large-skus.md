# ADR-0004: Custom policy denying VM SKUs above DS2_v2 baseline

**Status:** Accepted

## Context
The lab budget is $300 total. A single misconfigured VM at Standard_E32s_v3 would exceed the budget many times over within hours.

## Decision
Author a custom Azure Policy with effect=deny on `Microsoft.Compute/virtualMachines/sku.name` not in approved list. Assign at MG scope as part of the Lab Hygiene Initiative.

## Consequences
- Accidental large-SKU deployments fail at the ARM API.
- New SKU approvals require updating the policy parameter list — deliberate friction.
- Production environments expand the allowlist; mechanism transfers cleanly.
