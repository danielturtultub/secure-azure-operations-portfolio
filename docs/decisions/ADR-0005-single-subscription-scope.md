# ADR-0005: Single-subscription scope

## Status
Accepted — 2026-05-19

## Context
The lab assumes two onboarded Azure subscriptions to demonstrate
management-group-scope policy inheritance and cross-subscription
role assignment. Only one subscription (Azure for Students) is
available to this lab.

## Decision
Proceed with one subscription. The management group is still
deployed with one onboarded subscription so the hierarchy and
policy-assignment patterns are exercised — the inheritance proof
across two subs is the only thing that cannot be demonstrated.

Lab steps skipped:
- [01-03] onboard secondary subscription
- [01-07] policy denial test in secondary
- [01-18] cross-sub Reader role assignment

## Consequences
- Resume bullets must say "MG-scope policy assignment with hierarchy
  designed for multi-sub inheritance" rather than "inheritance
  demonstrated across two subscriptions."
- Compliance dashboard shows one subscription.
- All other content (custom policy authoring, initiatives, locks,
  budgets, Advisor, tag inheritance, Modify effects) is unaffected.