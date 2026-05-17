# Module 00 — Project foundation

The setup module. By the end, you have a versioned GitHub repository with branch protection and PR-based workflow, the Azure CLI and PowerShell tooling installed and authenticated, two Azure subscriptions identified for the multi-subscription work in module 01, a $100/month subscription budget with three alert thresholds on each subscription, the twelve-module folder skeleton committed, and the architecture and tagging standards locked in. No Azure resources are deployed yet beyond empty resource groups, so this module costs nothing.

## What this module demonstrates

| Skill | Where it shows up |
|---|---|
| Source-control discipline | Branch protection, PR-based workflow, conventional commits |
| Documentation as a deliverable | README, architecture doc, ADRs, glossary, naming standard |
| Tooling fluency | Azure CLI, Azure PowerShell, Bicep CLI, Microsoft Graph PowerShell, UTM virtualization for hybrid identity |
| Multi-subscription planning | Two subscriptions identified, MG hierarchy designed before any deployment |
| Cost governance from day one | Subscription budget with three alert thresholds before the first resource is created |
| Repository hygiene | `.gitignore` blocking PRIVATE files, MIT license, SECURITY policy, video script template |

## Build steps

This module uses **Azure CLI for tenant operations and Bash for repository scaffolding**. Portal is used only for the budget configuration where the wizard is faster than the equivalent CLI call.

### 1. Install tooling

```bash
# Azure CLI
az --version || curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash

# PowerShell 7
pwsh --version || brew install --cask powershell

# Az and Microsoft Graph PowerShell modules (modern path; AzureAD and MSOnline are end-of-life)
pwsh -Command "Install-Module Az -Scope CurrentUser -Force"
pwsh -Command "Install-Module Microsoft.Graph -Scope CurrentUser -Force"

# Bicep
az bicep install
az bicep version
```

### 2. Install UTM for the hybrid identity module's local Windows Server VM

UTM is a free macOS virtualization tool. Install via `brew install --cask utm` or download from `getutm.app`. A Windows Server 2022 evaluation ISO will be downloaded in module 11; UTM provides the hypervisor.

### 3. Authenticate to both Azure subscriptions

```bash
az login --use-device-code
az account list -o table
# Note both subscription IDs — primary and secondary
```

### 4. Create the GitHub repo

```bash
gh repo create secure-azure-operations-portfolio --public \
  --description "Hands-on Azure environment: identity, networking, compute, storage, monitoring, backup, security, hybrid identity, and IaC."

git clone https://github.com/<your-handle>/secure-azure-operations-portfolio.git
cd secure-azure-operations-portfolio
```

Configure branch protection on `main` requiring pull request reviews, linear history, and conversation resolution.

### 5. Scaffold the twelve modules

```bash
for d in 00-project-overview 01-governance-cost 02-identity-rbac 03-networking 04-compute \
         05-storage 06-monitoring-logs 07-backup-recovery 08-security-operations \
         09-iac-automation 10-final-capstone 11-hybrid-identity-deployed; do
    mkdir -p "$d"/{screenshots,scripts,diagrams,docs,videos}
    echo "# $d" > "$d/README.md"
done

mkdir -p docs/decisions diagrams videos
```

### 6. Set the subscription budgets — both subscriptions

Configure $100/month budget on each subscription with alerts at 50/80/100%. The total project ceiling of $300 is tracked manually.

### 7. Initialize the documentation

Copy the four top-level docs from this package, customize placeholders, and commit.

### 8. Add license, security policy, gitignore, video script template

`.gitignore` blocks `PRIVATE_*`, `.env*`, `*.pem`, `*.key`, `*.pfx`, `secrets/`. SECURITY.md describes the lab nature of the repository. MIT license. `videos/00-script-template.md` is the template every per-module video script follows.

### 9. Author the first ADR

`docs/decisions/ADR-0001-hub-and-spoke.md` — Context, Decision, Consequences. Two pages or less.

### 10. Final commit

```bash
git add .
git commit -m "feat(00): project foundation — tooling, scaffolding, governance baseline"
git push origin dev
gh pr create --title "Module 00: project foundation" --body "Foundation set."
```

## Validation

- `az --version`, `pwsh --version`, `az bicep version` all return current versions.
- `az account list` shows two subscriptions accessible.
- The twelve module folders exist with subfolders.
- The repo has a top-level README rendering with the Mermaid architecture diagram on github.com.
- Cost Management → Budgets shows budgets on both subscriptions with three alert thresholds.
- `.gitignore` contains `PRIVATE_*` and is committed.
- ADR-0001 exists.

## Cleanup

Nothing to clean up — no Azure resources were deployed.

**Cost:** $0 spent on this module. Sustained add: $0/month.

## Evidence

| File | Demonstrates |
|---|---|
| `screenshots/00-az-version.png` | CLI tooling installed and authenticated |
| `screenshots/00-two-subscriptions.png` | Two Azure subscriptions accessible |
| `screenshots/00-budgets-both-subs.png` | Budgets configured on both subscriptions |
| `screenshots/00-branch-protection.png` | PR requirement on `main` |
| `screenshots/00-utm-installed.png` | UTM virtualization installed for hybrid identity work |
| `screenshots/00-folder-skeleton.png` | Tree view of the twelve module folders |
| `screenshots/00-readme-renders.png` | README rendering with Mermaid diagram on github.com |
| `diagrams/00-tooling-overview.mmd` | Mermaid showing tooling chain |
| `videos/00-script-template.md` | Reusable five-minute video script template |
| `docs/decisions/ADR-0001-hub-and-spoke.md` | Hub-and-spoke decision record |

## Resume bullets

- Established a production-style Azure portfolio repository with branch-protected main, pull-request workflow, conventional commits, and a published Architecture Decision Record series spanning twenty-two consequential design choices.
- Configured per-subscription budgets with three alert thresholds before deploying any billable resource across two onboarded Azure subscriptions, demonstrating cost governance discipline aligned with multi-subscription operating models.
- Standardized tooling on Azure CLI, Azure PowerShell, Microsoft Graph PowerShell, Bicep CLI, and UTM virtualization for hybrid-identity work, replacing the deprecated AzureRM, AzureAD, and MSOnline modules across all subsequent automation.
- Authored a tagging policy with five required tags enforced via Azure Policy at management group scope and a naming standard applied consistently across two subscriptions and twelve service domains.
- Created a video walkthrough scripting standard (five-minute three-act structure) to be applied across each module's optional walkthrough recording.
- Set up a UTM virtualization environment for hosting an on-premises Windows Server domain controller, enabling deployed-end-to-end hybrid identity demonstrations in module 11.
- Designed a Public/Private file separation enforced at the repository level via `.gitignore`, ensuring sensitive planning documents never reach the public repository.
- Produced an architecture decision record for the hub-and-spoke topology choice within the first session, setting the documentation standard for the remaining 21 ADRs.

## Interview stories

### Beginner story — "How do you start a new cloud project?"

Repository, branch protection, and pull-request workflow before any code. Tooling and authentication next, with a written record of which modules are deprecated and why. Budget and alerts before the first deployment, because cost surprises are the most preventable failure in cloud work. Tagging and naming standards before the first resource, because retroactive tagging is painful. Then the first ADR documenting why the topology is what it is. The interviewer is looking for someone who treats foundations as a deliverable, not as overhead.

### Intermediate story — "Why two subscriptions?"

Single-subscription environments hide the hardest cross-cutting Azure problems: management group inheritance, cross-subscription role assignments, policy assignment scope debates, cost allocation across team boundaries. The portfolio onboards two subscriptions under a single Lab management group from day one. This unlocks the User-Access-Administrator-at-MG-scope pattern (one role assignment grants delegation across both subscriptions), the policy-inheritance pattern (one policy assignment at MG covers both subscriptions), and the cost-rollup pattern (Cost Management → MG view aggregates spend). The lesson: production-style problems require production-style scope.

### Architecture-level story — "How do you bound the scope of a portfolio project?"

Two failure modes. First, scope creep: every interesting Azure service gets added until the project becomes unfinishable. Second, scope under-shoot: a single working VM gets built and called a portfolio. The discipline is constraint-first design — pick the scope before authoring the plan. This portfolio's constraint set: twelve modules covering the full Azure administration surface, $300 total budget, 60-day execution window, one engineer, hybrid identity actually deployed, security posture demonstrated through deployed Defender plans not just diagrams. Every "nice to have" outside that constraint set was rejected and recorded in the decisions folder so reviewers can see what was excluded and why. The architecture lesson: the rejected-options list is part of the design.

## Five-minute video script

See `videos/00-script.md` for the full outline. Hook: *"Most cloud portfolios start with a VM. This one starts with a tagging policy. Here's why that matters and what gets built first."*
