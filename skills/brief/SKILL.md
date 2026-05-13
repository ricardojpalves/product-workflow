---
name: brief
description: Use mid-development on any project to reconstruct a comprehensive, structured project overview from existing code, docs, and artifacts. Produces a shareable brief covering purpose, stack, users, features, decisions, and current status — with source links throughout.
---

# /brief

## Overview

Generates a complete project brief by reading the repository as it exists today — no templates, no guesswork. Works on any codebase, whether or not it uses the product-workflow skill set.

**When to use:**
- Onboarding a collaborator or new agent session
- Reconnecting after a break ("what even is this project again?")
- Creating a shareable one-pager for stakeholders
- Sanity-checking that docs match reality

**Output:** Full brief written to `brief-[project-name]-[YYYY-MM-DD].md` in the project root. Chat shows a condensed summary only.

---

## Phase 1 — Discovery

Read everything available. For each file found, note its path — these become the source attribution links in the output.

### Product docs (read if present)
- `PRD.md` / `prd.md` — purpose, users, scope
- `ARCHITECTURE.md` / `architecture.md` — stack, data flow, services
- `AI-RULES.md` / `ai-rules.md` — non-negotiables, constraints
- `PLAN.md` / `plan.md` — phases, roadmap
- `DESIGN.md` / `design.md` — visual identity, tokens
- `memory.md` — latest session state, open questions
- `decisions.md` — architectural and product decisions
- `features.md` — V1/V2 feature split
- `app-concept.md` — positioning, monetisation, competitive landscape
- `brand.md` — brand identity
- `CHANGELOG.md` / `changelog.md` — release history

### Standard project files (read if present)
- `README.md` — public-facing description
- `package.json` / `pubspec.yaml` / `pyproject.toml` / `Cargo.toml` — name, dependencies, scripts
- `.env.example` / `.env.local.example` — environment variables and services in use
- `CLAUDE.md` / `AGENTS.md` / `GEMINI.md` — agent rules and project-specific context

### Kanban board (read if present)
Look for `*.md` files in common kanban locations:
- `*-board.md` in project root or any subfolder
- Any file containing `kanban-plugin` in its frontmatter

### Security and quality (read if present)
- `security-audit-*.md` — most recent audit file (sort by date, take latest)

### Git history (run if git repo)
```bash
git log --oneline -20          # recent activity
git log --oneline --all | wc -l  # total commits
git log --format="%ad" --date=short | tail -1  # project start date
git log --format="%ad" --date=short | head -1  # most recent commit
```

### Folder structure (always run)
```bash
ls -1          # top-level directories and files
```
For each top-level directory, note its apparent purpose (app, api, components, etc.)

---

## Phase 2 — Synthesis

After reading everything, synthesise into the output format below. For every section:
- Pull from the most authoritative source found (docs > README > package.json > inferred from code)
- Include a `_Source:_ [filename]` line after each major section — link to the actual file read, not a template path
- If a piece of information was inferred (not explicitly stated), mark it: *(inferred from [file])*
- If a section cannot be populated at all, write: *Not documented — add to [suggested file].*

---

## Output Format

Write the full brief to `brief-[project-name]-[YYYY-MM-DD].md` in the project root.

```markdown
# [Project Name] — Project Brief
Generated: [YYYY-MM-DD] | Sources: [count] files read

---

## What It Is
[2–3 sentences: what the product does, who it's for, and the core value proposition.]

_Source: [primary file used]_

---

## Problem & Purpose
[The problem it solves. The "why now". Who feels this pain and how badly.]

_Source: [primary file used]_

---

## Target Users
[Specific user segment(s) — roles, situations, not generic personas.]

_Source: [primary file used]_

---

## Stack & Architecture
| Layer | Technology |
|---|---|
| Frontend | [e.g. Next.js 14, React Native + Expo] |
| Backend | [e.g. Supabase, Express, FastAPI] |
| Database | [e.g. Postgres via Supabase] |
| Auth | [e.g. Supabase Auth, NextAuth] |
| Payments | [e.g. Stripe] |
| Hosting | [e.g. Vercel, Railway, Fly.io] |
| AI | [e.g. Anthropic claude-sonnet-4-6] |
| [Other] | [any significant service or library] |

[1–2 sentences on key architectural decisions or constraints.]

_Source: [architecture.md / package.json / inferred from dependencies]_

---

## Integration Map
External services and APIs the project depends on:
| Service | Purpose | Configured via |
|---|---|---|
| [e.g. Stripe] | [e.g. Payments, webhooks] | [e.g. STRIPE_SECRET_KEY] |
| [e.g. Resend] | [e.g. Transactional email] | [e.g. RESEND_API_KEY] |

_Source: [.env.example / architecture.md / inferred from code]_

---

## Features & Scope
### In Scope
| Feature | Status | Phase |
|---|---|---|
| [Feature name] | [Shipped / In Progress / Planned] | [V1 / V2] |

### Out of Scope (deliberate)
| Feature | Reason |
|---|---|
| [Feature name] | [Why not in V1] |

_Source: [features.md / PRD.md / kanban board]_

---

## Current Status
**Phase:** [e.g. V1 development — 60% complete]

**In Progress:**
- [Task from kanban]

**Queue:**
- [Task from kanban]

**Blocked:**
- [Task — reason]

**Recently Done:**
- [Last 3–5 completed items]

_Source: [kanban board / memory.md]_

---

## Key Decisions
[3–5 most important architectural or product decisions, each in one line with rationale.]

| Decision | Rationale | Superseded? |
|---|---|---|
| [e.g. Supabase over Firebase] | [e.g. Postgres needed for relational data] | No |

_Source: [decisions.md]_

---

## Pricing & Monetisation
[Free/paid tiers, pricing model, trial structure. If not yet defined: note it.]

_Source: [PRD.md / app-concept.md]_

---

## Open Questions
[Unresolved items that matter for the next phase of work.]

| Question | Domain | Age |
|---|---|---|
| [Question text] | [Product / Engineering / Design] | [days old if datable] |

_Source: [PRD.md / memory.md]_

---

## Security Posture
[Last audit date and score if available. Key findings still open.]

_Source: [security-audit-[date].md — if no audit file found, note: "No audit on record — run /security-audit before launch"]_

---

## Design System
[Brand direction, primary colors, typography, key tokens if defined.]

_Source: [DESIGN.md / brand.md]_

---

## Folder Structure
```
[project-root]/
├── [dir/]    — [purpose]
├── [dir/]    — [purpose]
└── [file]    — [purpose]
```

_Source: directory listing_

---

## External Resources
| Resource | Link / Location |
|---|---|
| Repository | [git remote URL or "local only"] |
| Deployed app | [URL from README / memory.md / .env, or "not yet deployed"] |
| Design file | [Figma URL or "not found"] |
| Kanban board | [path to board file] |

---

## Sources Used
Files read to produce this brief:
- `[filename]` — [what it contributed]
- `[filename]` — [what it contributed]
- *(git history — [N commits, [start date] → [end date]])*

Files not found (information gaps):
- `[filename]` — [what would be here if it existed]
```

---

## Chat Summary Format

After writing the file, show only this in chat:

```
## [Project Name] — Brief

**What it is:** [1 sentence]
**Stack:** [comma-separated key tech]
**Status:** [current phase + % complete estimate]
**Open questions:** [count]
**Security:** [last audit date + score, or "no audit on record"]

Full brief saved to brief-[project-name]-[YYYY-MM-DD].md

[N] files read | [N] gaps identified
```

---

## Graceful Degradation

The brief must always be produced, even when most files are missing. Rules:

| Situation | Behaviour |
|---|---|
| No product-workflow docs at all | Pull from README + package.json + folder structure. Mark all inferred sections clearly. |
| No kanban board | Skip "Current Status" kanban section; pull from git log for recent activity instead |
| No DESIGN.md | Note "No design system documented" — suggest creating one |
| No git history | Skip git-sourced sections; note "Not a git repository" |
| No README | Use package.json name/description as fallback |
| Completely undocumented project | Still produce brief from code structure — every section marked *(inferred)* |

Never leave a section blank. Either populate it, mark it inferred, or note what file would contain it.

---

## Common Mistakes

| Mistake | Fix |
|---|---|
| Omitting source attribution on sections | Every section needs a `_Source:_ [file]` line |
| Leaving gaps when files are missing | Use graceful degradation — infer from code or note the gap |
| Summarising rather than synthesising | Pull actual content from docs; don't paraphrase generically |
| Writing the full brief to chat | Chat shows condensed summary only — full detail goes to the file |
| Not checking for kanban board | Board files may be in subfolders — search for `kanban-plugin` |
