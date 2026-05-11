---
name: start-project
description: Use when starting a new project, kicking off a build, or setting up a fresh repo. Runs the full discovery workflow — brainstorm → 4 docs (PRD, architecture, ai-rules, plan) → triad review → kanban setup. Asks one question at a time with grounded recommendations.
---

# /start-project

## Overview

Project kickoff workflow. Builds the four foundational documents (PRD → Architecture → AI Rules → Plan) plus supporting files (DESIGN.md if UI, memory.md, decisions.md, Obsidian Kanban) by interviewing the user, drafting docs, running a triad review, then locking the foundation.

## Core principle

**Every question comes with grounded recommendations.** Never ask blind. Suggestions get smarter as the conversation progresses, drawing from prior answers.

## When to use
- New project from scratch
- Restarting an existing project that lacks structured docs
- User describes an idea and wants to formalize it before building

## When not to use
- One-off scripts or throwaway prototypes
- Existing projects with all 4 docs already in place — use `/triad-review` instead for scope shifts

## Workflow

```
1. Setup
   → Ask: project name, folder path, project type (solo or work)
   → Confirm before any files are written
   → Create folder, init git
   → Initialize Obsidian Kanban from templates/kanban.md

2. PRD discovery
   → Route to PRD-solo.md or PRD-work.md based on project type
   → Run question script (questions-prd.md)
   → Each question: state it + offer 2–3 grounded suggestions + recommend one + offer "or your own answer"
   → Draft PRD → user confirms or refines

3. Architecture discovery
   → Run question script (questions-architecture.md)
   → Pull defaults from user's CLAUDE.md if it exists
   → Draft architecture.md → user confirms

4. AI rules discovery
   → Run question script (questions-rules.md)
   → Suggest from a baseline of common security + quality rules
   → Draft ai-rules.md → user confirms

5. Pre-mortem (runs BEFORE triad review)
   → See pre-mortem.md
   → Ask "imagine it failed — what killed it?"
   → Classify 5–10 risks as 🐯 Tiger / 📄 Paper Tiger / 🐘 Elephant
   → Output as table → user confirms → feeds into triad

6. Triad review (auto-runs at end of doc creation)
   → Invoke dispatching-parallel-agents skill
   → Dispatch 3 subagents in parallel: PM, Design, Engineering
   → Each critiques the 3 docs + pre-mortem classification (see triad-prompts.md)
   → 3-round discussion (independent → cross-read → synthesis)
   → Output: visual tables with Top 3 actions ranked first
   → User decides which findings to incorporate → docs updated

7. Plan
   → Now (and only now) draft plan.md from locked PRD/Architecture/Rules + pre-mortem
   → Tigers become Phase 0 / Phase 1 actions
   → Paper Tigers + Elephants go in Risks section with target phase
   → Phased roadmap → populate Obsidian Kanban Queue

8. DESIGN.md (only if UI project)
   → Trigger DESIGN.md questionnaire (per user's CLAUDE.md global rule)

9. Final memory + decisions seed
   → Create memory.md with kickoff entry
   → Create decisions.md with any decisions made during discovery

10. Confirmation
   → Show all files created
   → Suggest next step: "Ready to build? Run /do to execute Phase 1 of plan.md"
```

## Question pattern (mandatory)

Every question follows this structure:

```
[QUESTION]

Based on [what we know from prior answers], here are options:
1. [Option A] — [why it fits]
2. [Option B] — [why it fits]
3. [Option C] — [why it fits]

*My recommendation:* [Pick + one-line reasoning]

Or describe your own answer.
```

Suggestions are **skippable** — if the user already provides the answer, move on without offering options.

## Inputs to read before asking

Before starting, read in parallel:
- User's `~/.claude/CLAUDE.md` (preferences, default stack, principles)
- Any opening brain-dump from the user
- If a project folder exists: existing memory.md, decisions.md, features.md

## Templates used

All from `templates/` in the product-workflow repo:
- `PRD-solo.md` (solo path)
- `PRD-work.md` (work path)
- `architecture.md`
- `ai-rules.md`
- `plan.md`
- `memory.md`
- `decisions.md`
- `kanban.md`

## Sub-references

- Question scripts: `questions-prd.md`, `questions-architecture.md`, `questions-rules.md`
- Pre-mortem classification: `pre-mortem.md`
- Triad agent prompts: `triad-prompts.md`

## Common mistakes

| Mistake | Fix |
|---|---|
| Asking question without grounded suggestions | Always offer 2–3 options + recommend one |
| Drafting the Plan before Triad review | Plan comes ONLY after PRD/Arch/Rules are locked |
| Skipping the "Out of Scope" section | This is the anti-scope-creep mechanism — never skip |
| Rushing past vague answers | Push back: "Can you narrow that further?" |
| Not asking solo vs work upfront | Routes to wrong PRD template |
