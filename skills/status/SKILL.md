---
name: status
description: Use when user asks "where are we?", "what's the project status?", "give me an update", or wants a snapshot of current state. Reads kanban + memory.md + decisions.md and outputs a structured status report. Supports daily-update mode (S.P.A.R.K.) and stakeholder-report mode (What/Who/When/How).
---

# /status

## Overview

Project status snapshot. Reads project state files and outputs a structured report. Supports three output modes:

1. **Default snapshot** — quick visual of current state (in progress / queued / blocked / done)
2. **S.P.A.R.K.** — daily update format for personal work tracking
3. **Stakeholder report** — long-form What/Who/When/How for sharing with others

## When to use
- User asks for project status, update, or snapshot
- Before/after a session to capture state
- Preparing to communicate progress to others

## When not to use
- Project hasn't been initialized with `/start-project`
- User wants to *change* status (use Kanban edit instead)

## Inputs to read

In parallel:
1. Project's Obsidian Kanban board (path from config — usually `/Users/Local Projects/Obsidian-Kanban/<project>/<project>-board.md`)
2. Project's `memory.md` (last 3 entries)
3. Project's `decisions.md` (last 5 decisions)
4. Project's `plan.md` (current phase)
5. Project's `PRD.md` (Open Questions section)

## Output: Default snapshot

```
🎯 Project: [Name]
📅 Day [N] of project · Phase: [current phase]
🟢 Health: On track  /  🟡 At risk  /  🔴 Off track

🔵 In Progress (X)
  • [Task]

⬜ Queue (X)
  • [Task] · V1
  • [Task] · V2

🔴 Blocked (X)
  • [Task] — [reason · since when]

🟢 In QA (X)
  • [Task]

✅ Done this week (X)
  • [Task]

🆕 Recent decisions
  • [Decision title] · [date]

❓ Open questions
  • [Question]

⏭️ Suggested next: [Recommendation based on what's blocked or queued]
```

## Output: S.P.A.R.K. mode

Triggered by `/status spark` or when user asks for a daily update.

```
📝 Daily Update — [Date]

S — Specific work completed:
   [What exactly you finished — concrete, not "worked on X"]

P — Problems & solutions:
   [What slowed you down. How you solved it.]

A — Adjustments made:
   [What changed in approach. Why.]

R — Rationale for decisions:
   [Why this approach over alternatives.]

K — Key priorities for today:
   [Main focus. Any help needed.]
```

Pull P / A / R from memory.md + decisions.md (last 24h). Pull S from kanban (Done since yesterday). Pull K from In Progress + top of Queue.

## Output: Stakeholder report

Triggered by `/status stakeholder` or when user mentions reporting to someone.

```
📣 Stakeholder Report — [Project] — [Date]

What: [Project name. The update or issue. Severity.]
Who:  [Who's involved. Who needs to act.]
When: [Timeline. When this happened. Deadlines.]
How:  [How we're handling it. What's needed from others.]
```

Pull from same sources but focus on signal-over-noise. Default to glass-of-water tone (factual, neither optimistic nor pessimistic).

## Health calculation

- 🟢 **On track:** No 🔴 Blocked items > 3 days. Current phase tasks tracking to plan.md timeline.
- 🟡 **At risk:** 1+ Blocked > 3 days, or any phase task > 50% over original estimate.
- 🔴 **Off track:** Multiple blockers, or phase deadline missed, or critical 🔴 items from `/code-audit` unaddressed.

## Suggested next step logic

Priority order:
1. Resolve blockers (highest impact — unblocks others)
2. Finish In Progress before starting new
3. Pick highest-priority Queue item that doesn't depend on a blocker
4. If no blockers and clear path: surface next phase milestone

## Common mistakes

| Mistake | Fix |
|---|---|
| Dumping every kanban item | Filter — show counts, list only what's actionable |
| Ignoring memory.md | Recent decisions + open questions belong in the snapshot |
| Generic "going well" tone | Apply glass-of-water principle — factual, specific, severity-aware |
| Confusing modes | Default snapshot ≠ stakeholder report. Ask if unclear. |
