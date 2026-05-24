# Evidence checklist — `01-governance-cost`

Capture each screenshot below as you complete the corresponding lab step.
Tick the box, save the file in `screenshots/` with the exact filename listed.

Cross-reference: see the corresponding section in the master `README.md` for context on each screenshot.

## Captured (9)

- [x] `screenshots/01-mg-hierarchy.png` — Lab MG with primary subscription onboarded
- [x] `screenshots/01-rgs-tagged-primary.png` — 10 RGs with all five required tags
- [x] `screenshots/01-policy-allowed-locations-mg.png` — Allowed-Locations policy at MG scope
- [x] `screenshots/01-policy-denial-westus-primary.png` — RequestDisallowedByPolicy in primary subscription
- [x] `screenshots/01-rg-lock.png` — CanNotDelete lock applied on rg-platform
- [x] `screenshots/01-lock-blocks-delete.png` — ScopeLocked error confirming lock works
- [x] `screenshots/01-initiative-mg.png` — Lab Hygiene Initiative assigned at MG scope
- [x] `screenshots/01-tag-inherit-remediation.png` — Inherit-Tag-RG Modify policy assigned at MG with managed identity
- [x] `screenshots/01-initiative-compliance-aggregated.png` — Compliance dashboard with all 5 assignments at 100% compliant


## Pending — to capture during remaining Module 01 work

- [ ] `screenshots/01-cost-mg-view.png` — Cost Management at MG scope (deferred — needs billable resources; capture in Module 04 after VM deployment)
- [ ] `screenshots/01-cost-by-module-tag.png` — Cost analysis grouped by Module tag (deferred — Azure Cost Management tag picker only shows tags after cost has accrued against them; capture after Module 04 VMs)
- [ ] `screenshots/01-advisor-five-categories.png` — All five Advisor categories captured
- [ ] `screenshots/01-mg-policy-exemption.png` — Policy exemption on a sandbox RG (later module)

## Skipped per ADR-0005 (single-subscription scope)

- [ ] ~~`screenshots/01-policy-denial-westus-secondary.png`~~ — would require second subscription
- [ ] ~~`screenshots/01-mg-reader-cross-sub.png`~~ — would require second subscription

## Common evidence patterns

- Each command-line capture should show the prompt, the command, and the relevant output.
- Portal captures should show the resource name in the breadcrumb and the relevant blade content visible.
- Validation captures should show success indicators (green checkmarks, '200 OK', successful deployment status).
- Failure captures (where the lab demonstrates a deny case) should show the exact error message and code (e.g., `RequestDisallowedByPolicy`, `ScopeLocked`).