# Product Workflow

A set of skills that bring real product-management practice to vibecoding — built around four foundational documents (PRD, Architecture, AI Rules, Plan), a product-triad review, and an adversarial code-audit loop.

For solo builders and product people who want **clarity before code**.

**Works with:** Claude Code · Codex CLI · any AI coding agent that supports the skills format.

---

## Why this exists

I'm a Product Manager. I build apps using AI coding tools — *vibe coding* — and I ship real products. I'd done the formal PM work for years before that: PRDs, JTBDs, RACI tables, triad reviews with engineering and design, weekly stakeholder updates. Then I started building solo with AI, and most of that scaffolding disappeared.

The result was predictable. Scope crept on every project. Decisions made on Monday were forgotten by Friday. I'd merge two sessions of work and find I'd contradicted myself. The "AI does the hard part" promise was true for code, but the *thinking* — what to build, who for, what not to build — that part was on me and I'd quietly let it slip.

So I built this workflow. It's not a 40-skill product-management marketplace. It's four composable skills, each doing one job, that bring the discipline I used to have on bigger teams to the solo builds I do now:

1. **`/start-project`** — discovery-first kickoff that produces a PRD, an architecture doc, an AI-rules doc, and a phased plan, in that order. With a product-triad review at the end (Product, Design, Engineering critique in parallel, debate, agree, hand back a top-3 action list). Includes a competitor research step before design, and a distribution question before the plan locks.
2. **`/brief`** — a mid-development project reconstruction that works on *any* repository. Reads code, docs, kanban, git history, and environment files to produce a complete, structured brief with source attribution on every section. The "what even is this project" command for new sessions, collaborators, and stakeholders.
3. **`/triad-review`** — the same triad, on-demand, for mid-project pivots and scope shifts. The "stop and think" button.
4. **`/code-audit`** — an independent code review run by a *different* LLM (Codex CLI by default). Different model = real critique, not Claude grading its own homework.
5. **`/status`** — a project snapshot, with daily-update, stakeholder-report, and code-health modes.
6. **`/pre-launch`** — a launch-readiness checklist that runs before going public. Covers code quality, infrastructure, auth, payments, email, and growth basics. Final step before real users arrive.

The framework is opinionated. It assumes you want fewer features shipped well, not more features shipped fast. It treats the **Out-of-Scope list as more important than the In-Scope list**. It refuses to let you build before deciding what you're building. None of that is novel — it's the boring, table-stakes product practice that exists everywhere except in solo vibecoding.

---

## What's in the box

### The four documents

```
1. PRD          → What you're building, who for, why, and what you're NOT building
2. Architecture → Stack, folder structure, naming, data flow
3. AI Rules     → Non-negotiables (security, quality, performance, accessibility)
4. Plan         → Phased roadmap (only after the first three are locked)
```

Saved as `.md` in the project root. Markdown is the native language of LLMs.

Two PRD templates:
- **PRD-solo** — lean 5 sections for side projects, indie tools, weekend builds
- **PRD-work** — full template with RACI, JTBDs, milestones table, stakeholder reporting for B2B / agency / multi-stakeholder projects

### The commands

| Command | When to use it |
|---|---|
| `/start-project` | New project. Discovery → 4 docs → pre-mortem → triad review → kanban setup. Includes competitor research before DESIGN.md and a distribution question before the plan locks. |
| `/brief` | Any project, any point in development. Reads the repo as-is and produces a complete project brief — purpose, stack, features, decisions, status, open questions, security posture. Works without product-workflow docs. |
| `/status` | Anytime. Snapshot (in progress / blocked / queued / done) + S.P.A.R.K. daily mode + stakeholder report mode + code health mode (end-of-day fragility check). |
| `/code-audit` | After implementing a feature. Independent code review by Codex CLI. Surfaces bugs, security issues, rule violations. |
| `/triad-review` | Mid-project, when scope shifts. PM + Design + Engineering subagents in a 3-round discussion (independent critique → cross-read → synthesis), ending in a force-ranked top-3 action list. |
| `/pre-launch` | Before going public. Launch-readiness checklist: code quality, infrastructure, auth/data, payments, email, growth basics. Final step before real users. |

### The product triad

Three roles, three lenses, one product:

- **Product Manager** — viability, scope, success metrics, strategic risk
- **Designer** — desirability, user flows, friction, accessibility, coherence
- **Engineering Lead** — feasibility, security, performance, architecture risk

`/start-project` runs the triad at the end of doc creation. `/triad-review` runs it on demand. Both produce a visual table with the **top 3 actions force-ranked first**, full findings collapsed beneath, and a guided supersede sub-flow when triad conclusions contradict prior decisions.

### Anti-scope-creep mechanism

Every PRD has a **Scope Table** — a single visual that lists requirements with `📥 In Scope` or `❌ Out of Scope`, each with a one-line "why not yet" for the out items. This is the strongest single mechanism for stopping the slow drift that kills V1 timelines.

### Pre-mortem risk classification

Before triad review, the workflow asks: *"Imagine it's 6 months from now. The project failed. What killed it?"* Risks are classified as:

- 🐯 **Tiger** — high likelihood + high impact (act now in Phase 0/1)
- 📄 **Paper Tiger** — looks scary but unlikely or easily mitigated
- 🐘 **Elephant** — slow-moving, will hit eventually if ignored

Every 🐯 must have a corresponding action in the plan. The triad reviews the classification too — PM checks business risks, Design catches UX miscategorisation, Engineering catches Tigers hiding as Elephants.

---

## How it works

### Discovery with grounded suggestions

Every question the workflow asks comes with **2–3 recommendations + reasoning**, drawn from your previous answers, your CLAUDE.md / AGENTS.md preferences, and general product knowledge. You're never asked a blank question.

Example: after you say "AI tutor for high school students," the next question doesn't ask "who's it for?" generically — it offers:
1. Top 10% high achievers (advanced prep market)
2. Middle 80% (largest, most underserved by current AI tools)
3. Bottom 10% (often reached via schools, different sales motion)

…with a recommendation and the reasoning behind it. You can pick, mix, or override.

### `/brief` — project reconstruction for any repo

Run `/brief` on any project at any point in development. It reads the repository as it exists — docs, code, git history, kanban board, environment files — and produces a structured brief from what it finds.

**Works without product-workflow docs.** If there's no PRD or architecture doc, it infers from README, package.json, folder structure, and git history. Every section shows where the information came from.

**What the brief contains:**
- What it is and the problem it solves
- Target users
- Full stack and integration map (external services, env vars)
- Feature list with status (Shipped / In Progress / Planned) and scope
- Current project status from kanban + recent git activity
- Key decisions with rationale
- Pricing and monetisation model
- Open questions with age
- Security posture (last audit date and score)
- Design system summary
- Folder structure with purpose annotations
- External resources (deployed URL, repo, design files)
- Sources used — every file read, with what it contributed

**Source attribution throughout.** Every section links to the file it was pulled from. If information was inferred rather than stated, it's marked *(inferred from [file])*. If a section can't be populated, it tells you which file to create.

**Output:** Full brief written to `brief-[project-name]-[YYYY-MM-DD].md` in the project root. Chat shows a one-screen summary.

### Adversarial code review

`/code-audit` calls Codex CLI (default) or Gemini CLI to review code as "audit code someone else wrote — find what's wrong." Frame matters: a model auditing its own work is polite; a model auditing someone else's is honest. Findings come back severity-grouped:

- 🔴 Critical (fix before merging)
- 🟡 Important (worth discussing)
- 🟢 Suggestion (nice to have)
- ✅ Verified good (explicitly checked, no issues)

Confirms before adding findings to Obsidian Kanban or fixing critical items. False positives don't pollute the board.

### Living documentation

Three layers, updated automatically as work progresses:

- **Obsidian Kanban** — visual state (In Progress / Queue / Blocked / QA / Done)
- **memory.md** — running session log, what was decided, open questions
- **decisions.md** — architectural and product decisions with rationale; superseded decisions marked, never deleted

`/status` reads all three plus PRD open questions, and aggregates them with **age** so 7-day-old unresolved questions get a ⚠️ — they're a smell.

---

## Installation

### Claude Code

**Option 1 — Clone with install script (auto-detects + symlinks):**

```bash
git clone https://github.com/ricardojpalves/product-workflow
cd product-workflow
./install.sh --claude
```

**Option 2 — Clone directly to skills directory:**

```bash
git clone https://github.com/ricardojpalves/product-workflow ~/.claude/skills/product-workflow
```

Then move or symlink each `skills/<skill-name>/` subdirectory into `~/.claude/skills/`.

### Codex CLI

```bash
git clone https://github.com/ricardojpalves/product-workflow
cd product-workflow
./install.sh --codex
```

The script symlinks each skill into `~/.agents/skills/` and installs a starter config at `~/.agents/product-workflow.config.md`.

### Both Claude Code and Codex CLI

```bash
./install.sh --all
```

### Other agents (Cursor, etc.)

Copy `skills/<skill-name>/` into whatever directory your agent reads skills from. The skill files are plain markdown with YAML frontmatter — portable across any tool that supports the skills format.

### Verify

Restart your AI coding tool, then type:

```
/start-project
```

If the discovery flow starts asking questions, you're set. See [INSTALL.md](INSTALL.md) for config, Codex CLI setup, and troubleshooting.

---

## Usage

In any project directory:

```
/start-project    # First time — runs full discovery + triad
/brief            # Any project, any time — reconstruct a full project brief from the repo
/status           # Anytime — project snapshot
/code-audit       # After implementing — independent review
/triad-review     # Mid-project — when scope shifts or you're stuck
/pre-launch       # Before going public — launch-readiness checklist
```

Each command stands alone. Use only what you need.

---

## Pair with `/security-audit`

This workflow handles the *product* side. For the *security* side — IDOR, RLS policies, webhook validation, secrets, rate limiting, race conditions — pair it with [solo-builder-security-audit](https://github.com/ricardojpalves/solo-builder-security-audit).

|  | This workflow | `/security-audit` |
|---|---|---|
| When | Throughout the project lifecycle | Pre-launch, pre-deploy |
| Scope | Discovery, planning, code review, status | Security and production-readiness |
| Outputs | PRD, architecture, plan, audit findings | Security report file + chat summary |
| Coverage | Product-management discipline | Security gaps in AI-built apps |

**Recommended:** Use both. This workflow keeps you building the right thing well; `/security-audit` makes sure it's safe to ship.

---

## Philosophy

A few opinions baked in. If you disagree with any, fork and override:

- **Clarity before code.** 30–60 minutes on PRD/Architecture/Rules saves days of rework.
- **Specificity over abstraction.** "Middle 80% of high schoolers" beats "students" every time.
- **The Out-of-Scope list is more important than the In-Scope list.** Features you say no to define the product.
- **Adversarial review beats agreeable review.** Frame audits as "someone else wrote this — find what's wrong." You'll get critique instead of compliments.
- **Different LLM for code audit.** Same model can't critique itself well. Use Codex against Claude or vice versa.
- **Suggestions with grounding, not blank questions.** Every question comes with 2–3 recommendations + reasoning.
- **Commit constantly.** Checkpoints are everything. Don't trust uncommitted state.
- **Fewer features shipped well > more features shipped fast.** This whole workflow is a forcing function for that.

---

## Credits & inspiration

- The four-document framework: [Don Allen III's "I Built a 19,000-Line iOS App Last Weekend"](https://substack.com/) (PRD → Architecture → Rules → Plan, save as `.md`, adversarial audit)
- The product triad: [Krystian M. Frahn's product triad model](https://www.linkedin.com/pulse/product-triad-agile-ux-meet-krystian-m-frahn-cejxf) (PM + Design + Engineering as collective ownership)
- DESIGN.md format: [Google Labs](https://github.com/google-labs-code/design.md)
- Pre-mortem classification (Tigers / Paper Tigers / Elephants): patterns from [phuryn/pm-skills](https://github.com/phuryn/pm-skills) and [product-on-purpose/pm-skills](https://github.com/product-on-purpose/pm-skills)
- Skill structure conventions: Anthropic's skill authoring best practices

---

## Contributing

The skills are deliberately opinionated. PRs welcome if they sharpen the existing skills without bloating the surface area. For new ideas, fork — different defaults serve different builders.

---

## License

MIT — use it, fork it, improve it.
