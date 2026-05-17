# Evidence and naming

This document defines how screenshots, diagrams, and configuration evidence are captured and stored across the portfolio. Higher evidence density than v2 — every module has at least 12 screenshots, several have 25+. Volume by itself is not the goal; volume of *intentional* evidence is.

## Folder layout per module

```
NN-module-name/
├── README.md             ← module narrative, build steps, evidence index
├── screenshots/          ← PNGs proving each configuration
├── diagrams/             ← .mmd Mermaid sources
├── scripts/              ← deployable code: Bicep, Bash, PowerShell, KQL queries
├── docs/                 ← supporting markdown: ADRs scoped to the module, design docs
└── videos/               ← .md video script outline (one per module)
```

## Screenshot filename convention

```
NN-<topic>-<state>.png
```

Where:
- `NN` is the module number
- `<topic>` is short kebab-case describing what the screenshot shows
- `<state>` indicates configuration phase when relevant: `before`, `after`, `success`, `failure`, `denied`, `fired`, `restored`

### Examples

| Filename | What it shows |
|---|---|
| `02-bulk-create-members.png` | Bulk-create wizard completed for member users |
| `02-contributor-cannot-assign.png` | AuthorizationFailed denial when Contributor attempts role assignment |
| `02-ca-policy-report-only.png` | Conditional Access policy in report-only state |
| `02-ca-report-only-signin-evaluation.png` | Sign-in log showing what report-only would have blocked |
| `03-firewall-rules-network.png` | Azure Firewall network rule collection deployed |
| `03-firewall-rules-application.png` | Firewall application rule collection with FQDN filtering |
| `03-appgw-waf-config.png` | Application Gateway WAF v2 in Prevention mode |
| `03-appgw-blocked-attack.png` | WAF logs showing a blocked SQL injection attempt |
| `03-front-door-routing.png` | Front Door Standard routing rules |
| `03-vpn-gateway-deployed.png` | VPN Gateway in GatewaySubnet with successful deployment |
| `06-sentinel-overview.png` | Sentinel enabled on Log Analytics workspace |
| `06-sentinel-analytics-rule.png` | Custom analytics rule for impossible-travel sign-ins |
| `06-sentinel-incident.png` | Sentinel incident triggered by analytics rule |
| `07-asr-replication-healthy.png` | ASR replication health green for one protected VM |
| `07-asr-failover-test.png` | Test failover initiated, VM running in target region |
| `07-asr-failback-complete.png` | Failback completed, VM running back in source region |
| `08-defender-servers-p2.png` | Defender for Servers Plan 2 enabled |
| `08-defender-storage.png` | Defender for Storage enabled |
| `08-defender-keyvault.png` | Defender for Key Vault enabled |
| `08-secure-score-before.png` | Secure score before remediation |
| `08-secure-score-after.png` | Secure score after applying recommendations |
| `11-windows-server-vm.png` | Local Windows Server 2022 VM running in UTM |
| `11-ad-ds-installed.png` | AD DS role installed, domain `contoso-test.local` provisioned |
| `11-entra-connect-sync-installed.png` | Microsoft Entra Connect Sync wizard completed |
| `11-sync-user-in-entra.png` | Synced user appearing in Microsoft Entra ID |
| `11-synced-user-signin.png` | Synced user signed into Azure portal with on-prem credentials |
| `11-password-hash-sync-verified.png` | Password change on-prem propagating to Entra |

## Diagram filename convention

```
NN-<topic>.mmd            (Mermaid source — preferred, renders on GitHub)
NN-<topic>.png            (rendered export, optional)
```

## Script filename convention

Scripts are named for what they do, not for the question they came from.

```
scripts/
├── modules/                     ← reusable Bicep modules
│   ├── vnet.bicep
│   ├── nsg.bicep
│   ├── storage.bicep
│   ├── keyvault.bicep
│   ├── firewall.bicep
│   ├── app-gateway.bicep
│   └── front-door.bicep
├── queries/                     ← saved KQL queries
│   ├── event-error.kql
│   ├── kv-unknown-caller.kql
│   ├── nsg-deny-trace.kql
│   └── sentinel-impossible-travel.kql
├── bulk-guest-invite.ps1
├── runbook-vm-schedule.ps1
├── runbook-expiry-cleanup.ps1
├── kill-switch.sh               ← end-of-session teardown
└── cleanup-orphans.sh           ← daily orphan audit
```

## Redaction rules — apply before every commit

Before any screenshot or output is committed to the public repo, blur or remove:

- Subscription IDs (full GUID)
- Tenant IDs (full GUID)
- Object IDs of users, groups, service principals (last half can be blurred)
- Personal email addresses
- Resource IDs containing real subscription GUIDs
- IP addresses mapping to home or workplace
- Any actual secret value, even base64-encoded
- API keys, access keys, SAS tokens, connection strings

## Evidence index per module

Each module README ends with an evidence table listing every screenshot, diagram, script, and ADR. Evidence count per module in v3:

| Module | Approx screenshots | Scripts | Diagrams |
|---|---|---|---|
| 00 Project overview | 5 | 1 | 1 |
| 01 Governance & cost | 18 | 4 | 3 |
| 02 Identity & RBAC | 28 | 3 | 4 |
| 03 Networking | 38 | 7 | 8 |
| 04 Compute | 22 | 4 | 3 |
| 05 Storage | 16 | 3 | 3 |
| 06 Monitoring & logs | 22 | 12 | 3 |
| 07 Backup & recovery | 18 | 2 | 3 |
| 08 Security operations | 24 | 4 | 4 |
| 09 IaC & automation | 16 | 8 | 3 |
| 10 Final capstone | 24 | 2 | 2 |
| 11 Hybrid identity | 14 | 2 | 2 |
| **Total** | **~245** | **~52** | **~39** |

Versus v2 totals (~93 screenshots, ~10 scripts, ~11 diagrams), v3 roughly **2.5x evidence density** — keeping the project bounded to a focused Azure admin scope while adding the deployed-not-designed weight.

## Validation evidence beyond screenshots

A screenshot proves a configuration existed. To prove the configuration *worked*, modules also include:

- **CLI output** captured to `.txt` files in `scripts/` (with sensitive values redacted)
- **KQL query results** exported as CSV when result counts or aggregations matter
- **Error captures** showing intentional misconfigurations being denied
- **Before/after pairs** for every remediation
- **Timed sequences** for operations like disk-move-without-VM-stop where the timing is the point
- **Failover/failback logs** for the ASR drill in module 07

## Reproducing the evidence

Each module README includes a "How to reproduce" section listing exact commands. A peer running through these in their own subscription should produce screenshots that look essentially identical, modulo subscription IDs, names, and timestamps. This is the test for whether the evidence is genuine — someone else can recreate it.

## Common evidence mistakes to avoid

A few patterns weaken the portfolio when reviewers see them:

Screenshots that show only the result without showing the configuration that produced it. Always pair "what I configured" with "what it did."

Screenshots cropped so tightly that the resource name, region, or scope is invisible.

Diagrams without labels — generic "VNet → VM" boxes. Use real names from the naming standard.

Mass screenshots from a single five-minute session. Real operational work has timestamps spread over days; a portfolio that shows all timestamps within ten minutes looks staged. Spread the build over multiple sessions.

Pixelated or resized screenshots. Capture at native resolution; PNG, not JPEG.
