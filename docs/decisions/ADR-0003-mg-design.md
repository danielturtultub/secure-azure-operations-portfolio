# ADR-0003: Management group hierarchy deployed (not designed)

**Status:** Accepted

## Context
Management Groups provide an inheritance scope above subscriptions for policy and access. v2 of this portfolio designed a hierarchy but did not deploy it. v3 deploys the hierarchy with two onboarded subscriptions.

## Decision
Deploy a `Tenant Root MG → Lab MG` hierarchy with both Azure subscriptions onboarded under Lab MG. Apply policies and Initiative at MG scope so both subscriptions inherit. Apply User Access Administrator at MG scope to demonstrate cross-subscription delegation.

## Consequences
- One policy assignment covers both subscriptions.
- One role assignment grants delegation across both subscriptions.
- Tenant root MG access required for the hierarchy creation; the elevate-access toggle in Microsoft Entra is used.
- Cost views aggregated at MG scope.
