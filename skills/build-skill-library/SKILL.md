---
name: build-skill-library
description: Use when capturing a mature project's knowledge as a portable .claude/skills/ library, when the user wants the project to survive losing access to a capable model, asks to "save the codebase as skills", or wants cheaper models to carry the project forward at the current standard.
---

# /build-skill-library

## Overview

Runs a three-phase process that turns a codebase's accumulated knowledge into a complete `.claude/skills/` library, authored by the most capable model available, so that cheaper models, future sessions, or a human developer can carry the project forward at the same standard. Based on `tomicz/fable-5-train-opus-skills-after-it-retires`; full notes in the wiki at `wiki/sources/ai-skills-tools/fable-skill-library-prompt.md` (PowerBrainWiki).

**Core principle:** models are rented; the skill files are owned. Capture the strong model's judgment in durable artifacts before access ends.

## When to use

- Project has reached a maturity milestone (pilot, launch, major phase done)
- Access to the current frontier model may end (plan change, policy, retirement)
- The user wants to hand work to cheaper models or another developer

## When not to use

- Early-stage projects still churning (the library would be stale in a week)
- A single insight worth capturing: put it in decisions.md or one small skill instead

## Before starting

Confirm with the user: this runs parallel agents and is token-heavy. Correctness is the priority, not cost. Suggest the most capable model available for the session.

## Phase 1: Discover before you write

Investigate the repo like an incoming principal engineer:

- README, manifest, contributor docs
- Build system, test suite, CI config
- Git history: what changed, what reverted, what stalled
- Open TODO/FIXME hotspots
- Generated data and deploy conventions
- Existing project memory: `memory.md`, `decisions-index.md` (search; open only matching decisions), the learnings Index. Never read `log.md` or `decisions.md` whole.

Then ask at most **5 questions**, one at a time, only for what the repo cannot tell you:

1. What is the hardest live problem right now?
2. What unwritten discipline rules exist (things never done that no doc states)?
3. Who is the audience and what do they NOT know?
4. What past failures cost the most time?
5. What does "beyond state of the art" mean for this project?

## Phase 2: Author the library (parallel agents)

One agent per skill, running in parallel. Target **10-16 skills**, adapted to what Phase 1 found. Chunk agent scope so each finishes well under the background-task watchdog, and give each agent a unique output path.

**Core taxonomy (every project):**

| Skill | Purpose |
|---|---|
| `<project>-change-control` | How changes are classified, gated, reviewed; non-negotiables with rationale and the incident behind each |
| `<project>-debugging-playbook` | Symptom-to-triage table for this project's failure modes; traps that cost real time, each with its story |
| `<project>-failure-archaeology` | Chronicle of every major investigation, dead end, rejected fix, and revert, so no one re-fights a settled battle |
| `<project>-architecture-contract` | Load-bearing design decisions and WHY; invariants that must hold; known weak points |
| `<domain>-reference` | Domain-theory knowledge pack a mid-level person lacks |
| `<project>-config-and-flags` | Every configuration axis: options, defaults, production vs experimental, guards, how to add one |
| `<project>-build-and-env` | Recreate the environment from scratch; known traps |
| `<project>-run-and-operate` | Running/deploying: command anatomy, data conventions, where output lands |
| `<project>-diagnostics-and-tooling` | How to measure instead of eyeball; diagnostic tools with interpretation guides |
| `<project>-validation-and-qa` | What counts as evidence; acceptance thresholds; how to add tests |
| `<project>-docs-and-writing` | Maintaining docs of record; templates; house style |
| `<project>-external-positioning` | What's novel vs known; reproducibility standards |

**Advanced (add when Phase 1 justifies them):**

| Skill | Purpose |
|---|---|
| `<project>-campaign` | Decision-gated campaign for the hardest live problem: phases, exact commands, expected observations at every gate, branch logic |
| `<project>-proof-and-analysis-toolkit` | First-principles analysis recipes, each with a worked example from this repo's history |
| `<project>-research-frontier` | Open problems: why current SOTA fails, this project's asset, first 3 steps, a falsifiable milestone |
| `<project>-research-methodology` | Evidence bar; hypothesis predicts numbers before running; idea lifecycle |

**Authoring rules (baked into every agent's prompt):**

- **Audience:** zero-context mid-level engineer or Sonnet-class model. Imperative runbook voice; copy-pasteable commands; jargon defined once; tables and checklists. Each skill says when NOT to use it and which sibling to use instead.
- **Format:** `.claude/skills/<name>/SKILL.md`, YAML frontmatter with `name` and a trigger-rich `description` (exactly when a model should load it, not what it does).
- **Ground truth only:** verify every command, flag, path, and claim against the repo before stating it. A wrong runbook is worse than none.
- **Embed knowledge:** never reference private or user-specific paths as load-bearing sources.
- **Date-stamp volatile facts:** end each skill with a "Provenance and maintenance" section containing re-verification commands for anything that may drift.
- **No oversell:** unproven things stay labeled open/candidate. No skill may contradict the project's docs or route around its change control.

## Phase 3: Review and fix (parallel reviewers)

Three parallel reviewers over the complete set:

- **Factual:** re-verify flags, paths, commands, citations against the repo; flag anything invented or stale
- **Doctrine:** contradictions with project rules or between skills; overstated claims; missing gating
- **Usability:** trigger quality of descriptions, duplication, self-containedness, scannability

One fixer applies all blocking issues. Final output to the user: skill inventory with one-line descriptions, what was verified, what remains uncertain.

## Common mistakes

| Mistake | Fix |
|---|---|
| Skipping Phase 1 and authoring from assumptions | Discovery first; the taxonomy adapts to what you find |
| One giant agent writing all skills | One agent per skill, parallel, unique output paths |
| Descriptions that summarize the skill's workflow | Descriptions state triggers only ("Use when...") |
| Trusting agent claims about the repo | Phase 3 factual review is mandatory, not optional |
| Treating the library as done forever | Provenance sections give each skill its re-verification path |
