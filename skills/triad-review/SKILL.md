---
name: triad-review
description: Use mid-project when scope shifts, before adding a major feature, after significant pivots, or when feeling unsure about direction. Runs PM + Design + Engineering through a 3-round discussion (independent critique → cross-read & converge → synthesis), ending in a force-ranked top-3 action list. Surfaces conflicts, marks consensus, prompts decision-supersede flow.
---

# /triad-review

## Overview

The "stop and think" button. Three roles (PM, Design, Engineering) work through a structured **3-round discussion** of the project's current PRD, architecture, and AI rules — independent critique, cross-read and converge, then synthesis.

Final output is a **force-ranked top-3 action list**, plus full findings and a sub-flow to supersede prior decisions if the triad's conclusions contradict them.

This is the mid-project version of the triad review that runs at the end of `/start-project`.

## When to use
- Scope is changing (feature added, removed, reshaped)
- Stakeholder requirement just landed
- Pivoting direction
- About to commit to a major architectural decision
- Project feels off-track and you can't articulate why

## When not to use
- Tiny changes (renaming a button)
- Tactical bug fixes (use `/code-audit`)
- When PRD/architecture/rules don't exist yet (use `/start-project`)

## Inputs

Read in parallel before dispatching:
- PRD.md
- architecture.md
- ai-rules.md
- decisions.md (last 10 — needed to detect supersede candidates)
- memory.md (last 3 sessions)

User provides the **specific question or change** to review:
- "We're considering adding offline mode — what would that break?"
- "I'm thinking of dropping social features. What are we missing?"
- "Should we move from Supabase to Firebase?"
- Or open: "Take a look — anything off?"

## Workflow

```
1. Read context files in parallel.

2. Capture user's review focus.
   → If user gave a specific question, use it.
   → If open-ended, ask: "Anything specific you want them to focus on?"

3. ROUND 1 — Independent critique (parallel)
   → Use dispatching-parallel-agents skill.
   → Each role gets full context + user's focus + their lens-specific prompt.
   → Each role is BLIND to what the others are reviewing.
   → Output: severity-grouped findings per role.

4. ROUND 2 — Discussion & convergence (parallel)
   → Use dispatching-parallel-agents skill again.
   → Each role gets their Round 1 + the other two roles' Round 1.
   → Each role: agrees / disagrees / refines / adds new.
   → Output: agreements, refinements, conflicts, new findings.

5. ROUND 3 — Synthesis (main thread)
   → Compile severity-grouped list combining R1 + R2.
   → Resolve remaining conflicts with recommendation + reasoning.
   → Force-rank "Top 3 to act on now" with owner + deadline.
   → Identify decisions that need to be superseded in decisions.md.

6. Present consolidated report to user.

7. Sub-flow: confirm Top 3 actions
   → For each, ask user: "Owner? Deadline?"
   → Add to memory.md as in-progress

8. Sub-flow: supersede prior decisions (if any)
   → For each candidate, ask user: "Supersede this decision? (y/n)"
   → If yes, prompt for replacement decision details
   → Update decisions.md (mark old as ⚠️ Superseded; add new entry)

9. Update artifacts
   → If scope changes → update PRD.md (Scope Table)
   → If architecture shifts → update architecture.md
   → If rules need adjustment → update ai-rules.md
   → Always: log the review + outcome to memory.md
```

## Triad prompts

The full 3-round prompt structure lives in `start-project/triad-prompts.md` (shared between `/start-project` end-of-flow and `/triad-review`). See that file for:
- Round 1 prompts (3 roles, blind)
- Round 2 universal preamble + role-specific framing
- Round 3 synthesis structure
- Output format presented to user

## Output format

See `start-project/triad-prompts.md` "Output format presented to user" section. The key differentiator vs old structure: **Top 3 force-ranked actions appear BEFORE the full findings**, so action priority is never lost in the noise.

## Decision-supersede sub-flow

When Round 3 identifies that a prior decision is contradicted by the triad's findings:

```
🔄 Decision supersede candidate

Prior decision: "[Title from decisions.md]"
  Date: [original date]
  Status: Active
  Reasoning: [original reasoning]

Triad finding that contradicts it:
  [Finding]

Recommended supersede:
  New decision: [Title]
  Reasoning: [Why this changes things]

Apply supersede? (y/n)
```

If yes:
1. Edit decisions.md: change old decision status to `⚠️ Superseded by [new title] on [today]`
2. Append "Why superseded:" line to old decision
3. Add new decision entry at top with full template
4. Cross-reference both ways

If no:
- Note the conflict in memory.md but leave decision active
- User accepts the risk explicitly

## Common mistakes

| Mistake | Fix |
|---|---|
| Skipping Round 2 (discussion) | Round 2 is the whole point — without it, you have 3 monologues |
| Burying top-3 actions in long report | Top 3 must appear FIRST in the output |
| Running triad on tiny questions | Triad is for scope/strategy. Use `/code-audit` for code, normal chat for tactics. |
| Skipping the user's focus | Always ask what to review. Open reviews tend to surface noise. |
| Not logging the outcome | Triad outcomes are decisions — they belong in decisions.md, not just chat. |
| Forgetting to check supersede candidates | Triad findings that contradict prior decisions MUST trigger the supersede sub-flow |
