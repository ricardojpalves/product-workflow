---
name: triad-review
description: Use mid-project when scope shifts, before adding a major feature, after significant pivots, or when feeling unsure about direction. Dispatches PM + Design + Engineering subagents in parallel to critique current PRD/architecture/rules from each lens. Returns consolidated findings.
---

# /triad-review

## Overview

The "stop and think" button. Three subagents (PM, Design, Engineering) review the project's current PRD, architecture, and AI rules in parallel — each from their lens. Consolidated findings surface conflicts, gaps, and risks before you commit to a direction.

This is the mid-project version of the triad review that runs at the end of `/start-project`.

## When to use
- Scope is changing (feature added or removed)
- Stakeholder requirement just landed
- Pivoting direction
- About to commit to a major architectural decision
- Project feels off-track and you can't articulate why

## When not to use
- Tiny changes (renaming a button)
- For tactical bug fixes (use `/code-audit`)
- When PRD/architecture/rules don't exist yet (use `/start-project`)

## Inputs

Read in parallel before dispatching:
- PRD.md
- architecture.md
- ai-rules.md
- decisions.md (last 5)
- memory.md (last 3 sessions)

User provides the **specific question or change** to review:
- "We're considering adding offline mode — what would that break?"
- "I'm thinking of dropping social features. What are we missing?"
- "Should we move from Supabase to Firebase?"
- Or open: "Take a look — anything off?"

## Workflow

```
1. Read context files in parallel

2. Capture user's review focus
   → If user gave a specific question, use it
   → If open-ended, ask: "Anything specific you want them to focus on?"

3. Dispatch 3 subagents in parallel using dispatching-parallel-agents skill
   → Each gets: full PRD + architecture + ai-rules + recent decisions + user's focus
   → Each gets a role-specific prompt (see triad-prompts.md in start-project skill)

4. Consolidate findings
   → Group by severity (🔴/🟡/🟢)
   → Highlight conflicts where reviewers disagreed
   → Mark consensus items where all three agreed

5. Present to user
   → Show consolidated report
   → Ask: "Which findings do you want to act on?"

6. Update artifacts
   → If decisions need to change → update decisions.md (mark old one superseded)
   → If scope changes → update PRD.md (Scope Table)
   → If architecture shifts → update architecture.md
   → If rules need adjustment → update ai-rules.md
   → Always: log the review + outcome to memory.md
```

## Triad prompts

Reuse the prompts from `start-project/triad-prompts.md`. The structure is identical:
- PM: viability / scope / metrics / strategic risk
- Design: UX / flows / friction / a11y / coherence
- Engineering: feasibility / complexity / security / scaling / build risk

Add the user's specific focus to all three prompts.

## Output format

```
🔍 Triad Review — [Project Name]
📅 [Date] · Focus: [user's question or "open review"]

🔴 Critical (X)
  • [Issue] — flagged by [PM / Design / Eng]

🟡 Important (X)
  • [Issue] — flagged by [PM / Design / Eng]

🟢 Suggestions (X)
  • [Item] — from [PM / Design / Eng]

✅ Consensus — all three agreed
  • [What's strong]

🤔 Conflicts — reviewers disagreed
  • Topic: [X]
    PM says: [...]
    Eng says: [...]
    Recommendation: [resolution]

📋 Next step:
  → Which findings to incorporate? (mark with ✓)
  → Update PRD / architecture / rules as needed
  → Log decision to decisions.md with rationale
```

## Common mistakes

| Mistake | Fix |
|---|---|
| Running triad on tiny questions | Triad is for scope/strategy. Use `/code-audit` for code, normal chat for tactics. |
| Skipping the user's focus | Always ask what to review. Open reviews tend to surface noise. |
| Not logging the outcome | Triad outcomes are decisions — they belong in decisions.md, not just chat. |
| Treating reviewer reports as gospel | They're inputs. User decides what to incorporate. |
