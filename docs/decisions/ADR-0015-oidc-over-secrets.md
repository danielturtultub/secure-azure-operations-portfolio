# ADR-0015: OIDC federated credentials over service principal secrets

**Status:** Accepted

## Context
GitHub Actions can authenticate to Azure via a service principal client secret stored as a GitHub Secret, or via OIDC federation.

## Decision
All CI/CD workflows authenticate via OIDC federation. The federated credential's `subject` field scopes the trust to a specific repo and branch. No client secret is stored.

## Consequences
- No secret to rotate, leak, or copy across environments.
- The federation subject is the security boundary.
- Pull requests from forks cannot impersonate the credential.
- Each environment gets its own federated credential.
