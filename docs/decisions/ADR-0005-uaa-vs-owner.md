# ADR-0005: User Access Administrator scoped narrowly over Owner for delegation

**Status:** Accepted

## Context
A team needs the ability to assign roles on a specific resource. Granting Owner on the parent RG gives the team far more permission than they need.

## Decision
Grant `User Access Administrator` scoped to the specific resource where delegation is needed, paired with a separate role granting the operational permissions they actually need.

## Consequences
- Two role assignments per delegated team — slightly more setup.
- Blast radius is bounded.
- Pattern transfers to PIM (eligible UAA assignments) when Microsoft Entra ID Premium P2 is available.
