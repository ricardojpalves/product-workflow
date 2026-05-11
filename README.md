# Product Workflow

A structured workflow for vibecoding projects — from idea to shipped — built around four foundational documents, a product-triad review, and an adversarial code-audit loop.

For solo builders and product people who want **clarity before code**.

**Works with:** Claude Code · Codex CLI · any AI coding agent that supports the skills format.

---

## The problem

Vibecoding without structure leads to three predictable failures:
- **Scope creep** — every session adds features, V1 never ships
- **Lost context** — decisions made on Monday are forgotten by Friday
- **Brittle quality** — security holes, dead code, no test coverage, surfaced too late

This workflow fixes all three by enforcing a sequence: **think clearly, then build**.

---

## The four documents

Inspired by [Don Allen III's "I Built a 19,000-Line iOS App Last Weekend"](https://substack.com/) framework, with patterns borrowed from real product management practice.

```
1. PRD          → What you're building, who for, why, and what you're NOT building
2. architecture → Stack, folder structure, naming, data flow
3. ai-rules     → Non-negotiables (security, quality, performance, accessibility)
4. plan         → Phased roadmap (only after the first three are locked)
```

Save everything as `.md`. Markdown is the native language of LLMs.

---

## The four commands

| Command | When to use it |
|---|---|
| `/start-project` | New project. Runs the full discovery: brainstorm → 4 docs → triad review → kanban setup. |
| `/status` | Anytime. Snapshot of state (in progress / blocked / queued / done) + S.P.A.R.K. or stakeholder report mode. |
| `/code-audit` | After implementing a feature. Independent code review by **Codex CLI** (different LLM = real critique). |
| `/triad-review` | Mid-project, when scope shifts. **PM + Design + Engineering** subagents in parallel critique current direction. |

---

## The product triad

Three roles, three lenses, one product. Inspired by [Krystian M. Frahn's product triad model](https://www.linkedin.com/pulse/product-triad-agile-ux-meet-krystian-m-frahn-cejxf):

- **Product Manager** — viability, scope, business fit, success metrics
- **Designer** — desirability, user flows, friction, accessibility
- **Engineering Lead** — feasibility, security, performance, architecture risk

Both `/start-project` (at the end) and `/triad-review` (on demand) dispatch all three as parallel subagents. Each critiques from their lens. Conflicts get surfaced — the user decides.

---

## The agentic workflow loop

Once docs are locked and you're building:

```
Direct → Implement → Verify → Commit → Update Context → Repeat
```

- **Direct** — give the agent a task from `plan.md`
- **Implement** — agent writes code
- **Verify** — `/code-audit` runs Codex against the diff (adversarial: "audit code someone else wrote")
- **Commit** — to GitHub. Frequently. Checkpoints save sanity.
- **Update Context** — append to `memory.md`, update kanban, log decisions to `decisions.md`
- **Repeat**

The hardest part is knowing when to stop. That's a creative decision, not a technical one.

---

## Two project types

### Solo
Lean PRD (5 sections), simplified plan, no RACI. For side projects, indie tools, weekend builds.

### Work
Full PRD with RACI, JTBD, milestones table, stakeholder reporting. For B2B, agency, multi-stakeholder projects.

`/start-project` asks upfront which path to take.

---

## Anti-scope-creep mechanism

Every PRD has a **Scope Table** — a single visual that lists requirements with `📥 In Scope` or `❌ Out of Scope`. Tempting features get listed explicitly as out-of-scope with a one-line "why not yet."

This is the strongest single mechanism for preventing the slow drift that kills V1 timelines.

---

## Status tracking

Three layers:

1. **Obsidian Kanban** — visual state (In Progress / Queue / Blocked / QA / Done), updated automatically as work progresses
2. **memory.md** — running session log, what was decided, open questions
3. **decisions.md** — architectural and product decisions with rationale, supersedes marked

`/status` reads all three and outputs a snapshot. Three modes:
- **Default snapshot** — quick visual
- **S.P.A.R.K.** — daily personal update (Specific / Problems / Adjustments / Rationale / Key priorities)
- **Stakeholder report** — long-form What/Who/When/How for sharing with others

---

## Installation

### Prerequisites
- One of: [Claude Code](https://claude.com/claude-code) or [Codex CLI](https://platform.openai.com/docs)
- (Optional but recommended for `/code-audit`) Codex CLI even if you primarily use Claude Code — `/code-audit` uses Codex as the adversarial second opinion
- (Optional) [Obsidian](https://obsidian.md/) with the Kanban plugin for visual status

### One-line install

```bash
git clone https://github.com/ricardojpalves/product-workflow.git
cd product-workflow
./install.sh
```

By default the script **auto-detects** whether you have Claude Code or Codex CLI installed and sets up skills in the right places:
- Claude Code → `~/.claude/skills/<skill-name>/`
- Codex CLI → `~/.agents/skills/<skill-name>/`

Force a specific install with flags:
```bash
./install.sh --claude     # Claude Code only
./install.sh --codex      # Codex CLI only
./install.sh --all        # Both
```

The script symlinks skills (not copies) so `git pull` updates flow automatically. A starter config is installed to `~/.claude/product-workflow.config.md` and/or `~/.agents/product-workflow.config.md`.

Then restart your AI coding tool to load the skills.

### Manual install (for other agents)

Copy `skills/<skill-name>/` into whatever directory your agent reads skills from. The skill files are plain markdown with YAML frontmatter — portable across any tool that supports the skills format (Cursor, custom setups, etc.).

See [INSTALL.md](INSTALL.md) for details and troubleshooting.

---

## Repo structure

```
product-workflow/
├── README.md
├── INSTALL.md
├── LICENSE
├── install.sh
├── skills/
│   ├── start-project/
│   │   ├── SKILL.md
│   │   ├── questions-prd.md
│   │   ├── questions-architecture.md
│   │   ├── questions-rules.md
│   │   └── triad-prompts.md
│   ├── status/
│   │   └── SKILL.md
│   ├── code-audit/
│   │   └── SKILL.md
│   └── triad-review/
│       └── SKILL.md
├── templates/
│   ├── PRD-solo.md
│   ├── PRD-work.md
│   ├── architecture.md
│   ├── ai-rules.md
│   ├── plan.md
│   ├── memory.md
│   ├── decisions.md
│   ├── kanban.md
│   └── status-report.md
├── examples/
│   └── (worked examples coming)
└── config/
    └── start-project.config.md
```

---

## Philosophy / opinions

This workflow has strong opinions. Here they are:

- **Clarity before code.** Spend 30–60 minutes on PRD/Architecture/Rules. It saves days of rework.
- **Specificity over abstraction.** "Middle 80% of high schoolers" beats "students" every time.
- **The Out-of-Scope list is more important than the In-Scope list.** Features you say no to define the product.
- **Markdown over docs.** LLMs trained on it. Talk to them in their language.
- **Adversarial review beats agreeable review.** Frame audits as "audit code someone else wrote." You'll get critique instead of compliments.
- **Different LLM for code audit.** Same model can't critique itself well. Use Codex against Claude or vice versa.
- **Suggestions with grounding, not blank questions.** Every question the workflow asks comes with 2–3 recommendations and reasoning.
- **One PM owns the V1 list.** Solo projects: that's you. Work projects: that's the Accountable in RACI.
- **Commit constantly.** Checkpoints are everything. Don't trust uncommitted state.

---

## Credits & inspiration

- The four-document framework: [Don Allen III](https://substack.com/), creative technologist
- The product triad model: [Krystian M. Frahn](https://www.linkedin.com/pulse/product-triad-agile-ux-meet-krystian-m-frahn-cejxf)
- DESIGN.md format: [Google Labs](https://github.com/google-labs-code/design.md)
- S.P.A.R.K. daily update framework: adapted from team practice
- The What/Who/When/How stakeholder reporting structure: adapted from team practice
- Skill structure conventions: Anthropic's [skill authoring best practices](https://docs.claude.com/)

---

## Contributing

Issues and PRs welcome. The skills are deliberately opinionated — fork if you want different defaults.

For new skills that fit the workflow, follow the structure in `skills/start-project/`. Keep YAML frontmatter to `name` and `description`. Put heavy reference material in separate `.md` files alongside `SKILL.md`.

---

## License

MIT — see [LICENSE](LICENSE).
