# Plan — [Project Name]

**Last updated:** YYYY-MM-DD · **Source of truth:** PRD.md + architecture.md + ai-rules.md

---

## Phase 1: Foundation
**Goal:** [What this phase delivers]
**Done when:** [Concrete completion criteria]

- [ ] Repo + tooling setup
- [ ] DESIGN.md created
- [ ] Database schema + migrations
- [ ] Auth flow
- [ ] [Other foundation tasks]

## Phase 2: Core Features (V1)
**Goal:** [What this phase delivers]
**Done when:** [Concrete completion criteria]

For each Key Element from PRD, list the tasks.

### [Key Element 1]
- [ ] [Task]
- [ ] [Task]
- [ ] [Task]

### [Key Element 2]
- [ ] [Task]
- [ ] [Task]

### [Key Element 3]
- [ ] [Task]
- [ ] [Task]

## Phase 3: Polish & Launch Prep
**Goal:** Production-ready quality
**Done when:** All ai-rules.md items pass code-audit

- [ ] Run `/code-audit` — fix all 🔴 critical, address 🟡 important
- [ ] Run `/emil-design-eng` — micro-interactions, transitions
- [ ] Run `/delight` → `/audit` → `/typeset` — design polish
- [ ] Cross-browser / cross-device testing
- [ ] Performance budget validation
- [ ] Accessibility audit
- [ ] README written

## Phase 4: Launch
**Goal:** V1 in users' hands
**Done when:** [Public-facing definition of done]

- [ ] Deploy to production
- [ ] Onboarding flow tested with real user
- [ ] Analytics + error tracking in place
- [ ] [Launch-specific tasks]

## Out of scope (V2+)
Tracked here so they don't get forgotten — but explicitly not in V1.

- [ ] [V2 item]
- [ ] [V2 item]

## Risks & dependencies

Classified per pre-mortem: 🐯 **Tiger** (high likelihood + high impact, act now) · 📄 **Paper Tiger** (looks scary, unlikely or easily mitigated) · 🐘 **Elephant** (slow-moving, will hit eventually).

| Risk | Bucket | Mitigation | Target phase |
|---|:-:|---|:-:|
| [Risk] | 🐯 | [Action — usually in Phase 0/1] | 0 / 1 |
| [Risk] | 📄 | [Monitor / single-line mitigation] | — |
| [Risk] | 🐘 | [Plan to address by this phase] | 3 / 4 |

**Rule:** Every 🐯 must have a corresponding action in Phase 0 or Phase 1 above.
