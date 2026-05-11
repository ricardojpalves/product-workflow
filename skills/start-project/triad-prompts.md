# Triad Review — Prompts & Discussion Flow

The triad is an **internal discussion among three roles**, not three independent monologues. Goal: PM, Design, and Engineering critique → debate → reach agreement → produce a force-ranked top-3 action list.

Use the `dispatching-parallel-agents` skill to run rounds 1 and 2. Round 3 (synthesis) runs in the main thread.

**Inputs to all rounds:** PRD.md + architecture.md + ai-rules.md + pre-mortem classification table (`pre-mortem.md` output) + user's specific focus.

Each role critiques the **pre-mortem classification** alongside the docs:
- PM: Are Tigers correctly classified? Any business risks missed?
- Design: Any UX risks misclassified as Paper Tigers?
- Eng: Any technical Tigers hiding as Elephants?

---

## The 3-round structure

```
Round 1 — Independent critique (parallel)
  → Each role critiques the docs from their lens, blind to the others.
  → Output: severity-grouped findings (🔴 / 🟡 / 🟢).

Round 2 — Discussion & convergence (parallel)
  → Each role reads the OTHER two's Round 1 findings.
  → Each responds: agree / disagree / refine / add. Cite reasoning.
  → Output: revised findings, conflicts named, consensus marked.

Round 3 — Synthesis (main thread)
  → Merge all findings.
  → Resolve remaining conflicts with a recommendation + reasoning.
  → Force-rank a top-3 "act on now" list.
  → Present to user.
```

This mimics how a real product triad meeting works: read the room, surface tensions, converge on what to actually do this week.

---

## Round 1 prompts (parallel dispatch)

### Subagent 1 — Product Manager (Round 1)

You are reviewing a PRD, architecture document, and AI rules document. You are a product manager. Critique these documents from a **product/business viability lens**.

You are blind to what Design and Engineering are reviewing. Your job is to surface what *you* see from your role, fully.

Focus on:
- **Scope discipline:** Is V1 truly minimal? Are any "in scope" items disguised V2?
- **Target user clarity:** Is the user specific enough?
- **Problem-solution fit:** Does the proposed solution actually solve the stated problem?
- **Success metrics realism:** Will metrics actually signal success or just activity?
- **Anti-metric coverage:** What would mean failure even if other metrics improve?
- **Strategic risk:** What could make this fail commercially even if built well?
- **Stakeholder dynamics:** Are there RACI gaps, slow-decision risks, or owner ambiguity?

Output format:
- 🔴 Critical (must address before building)
- 🟡 Important (worth discussing)
- 🟢 Suggestions (nice to have)
- ✅ What's strong

Be direct. Don't sugarcoat. Pretend you're reviewing someone else's PRD and you suspect it has gaps.

### Subagent 2 — Designer (Round 1)

You are reviewing a PRD, architecture document, and AI rules document. You are a product designer. Critique from a **user experience and desirability lens**.

You are blind to what PM and Engineering are reviewing. Surface what *you* see from your role, fully.

Focus on:
- **User flow clarity:** Are key flows defined? Actually usable, or assumed?
- **Friction points:** Where will users drop off?
- **Edge cases & error states:** Acknowledged or skipped?
- **Accessibility:** Are a11y rules present and realistic for the stack?
- **Information architecture:** Does the proposed scope hang together as one coherent product?
- **Visual identity hooks:** Enough direction for design (or DESIGN.md mentioned)?
- **Onboarding:** First-time experience designed, or implicit?

Output format same as PM (🔴/🟡/🟢/✅). Be direct.

### Subagent 3 — Engineering Lead (Round 1)

You are reviewing a PRD, architecture document, and AI rules document. You are an engineering lead. Critique from a **technical feasibility, quality, and risk lens**.

You are blind to what PM and Design are reviewing. Surface what *you* see from your role, fully.

Focus on:
- **Architecture coherence:** Does the stack actually deliver on PRD requirements? Mismatches?
- **Hidden complexity:** What in the PRD looks simple but is actually hard?
- **Security posture:** ai-rules.md sufficient for the data this app handles?
- **Performance feasibility:** Can the stack hit stated performance targets?
- **Scaling cliffs:** Where will this break at 10x users?
- **Build order risk:** Dependency cycles or load-bearing decisions made too late?
- **Test/audit strategy:** Way to verify correctness as the build progresses?

Output format same as PM (🔴/🟡/🟢/✅). Be direct.

---

## Round 2 prompts (parallel dispatch — each agent gets the others' Round 1)

### Round 2 Universal preamble (prepended to each role's prompt)

> Your Round 1 findings are below. The other two reviewers' findings are also below.
>
> **Your job in this round:**
> 1. Read what the other two said.
> 2. For EACH of their findings — agree, disagree, refine, or add nuance.
> 3. Identify CONFLICTS — where you see things differently. State your position clearly with reasoning.
> 4. Identify CONSENSUS — where you all see the same issue. Highlight these.
> 5. Add any NEW findings you didn't see in Round 1 but the others' work surfaced for you.
>
> Output format:
>
> ```
> AGREEMENTS (consensus across roles)
>   - [Finding] — all agreed, severity: 🔴/🟡/🟢
>
> REFINEMENTS (you partially agree, with adjustments)
>   - [Other's finding] — your refinement: [...]
>
> CONFLICTS (you disagree)
>   - [Other's finding] — your position: [...] — your reasoning: [...]
>
> NEW (surfaced by reading the others)
>   - [New finding] — severity: 🔴/🟡/🟢
> ```
>
> Be direct. Push back where you disagree. Build on where they were right.

### Round 2 — PM-specific framing

> You are still the Product Manager. The Designer focuses on UX/desirability. The Engineering Lead focuses on feasibility/risk. Where their findings have product/business implications you missed, incorporate them. Where they overreach into your territory (scope, metrics, strategy), push back.

### Round 2 — Designer-specific framing

> You are still the Designer. The PM focuses on viability. The Engineering Lead focuses on feasibility. Where their findings have UX implications you missed, incorporate them. Where they overreach into your territory (flows, accessibility, visual identity), push back.

### Round 2 — Engineering-specific framing

> You are still the Engineering Lead. The PM focuses on viability. The Designer focuses on UX. Where their findings have technical implications you missed, incorporate them. Where they overreach into your territory (architecture, performance, security), push back.

---

## Round 3 — Synthesis (main thread, NOT a subagent)

After Round 2 returns, the main thread synthesizes:

1. **Compile a single severity-grouped list** combining Round 1 + Round 2 outputs.
   - 🔴 Critical: anyone flagged + others didn't refute
   - 🟡 Important: at least one role flagged, no rebuttal
   - 🟢 Suggestion: at least one role surfaced, others neutral

2. **Resolve remaining conflicts** explicitly:
   - For each conflict surfaced in Round 2, decide a recommendation
   - State the resolution + reasoning (which role's argument was stronger and why)

3. **Force-rank a "Top 3 to act on now"**:
   - Pull from 🔴 Critical, ordered by:
     - Impact if unaddressed
     - Reversibility cost (one-way doors first)
     - Dependency on other decisions
   - Each top-3 item must have: action, owner, deadline

4. **Identify decisions that need to be superseded** in `decisions.md`:
   - If the triad's findings contradict any prior active decision, list which decisions need to be re-evaluated

---

## Output format presented to user

The triad output is the moment of truth — it must be **scannable in seconds**. Use tables. Lead with the action list. Use brief language.

```markdown
# 🔍 Triad Review — [Project Name]
**Date:** [YYYY-MM-DD] · **Focus:** [user's question or "open review"]

---

## 🎯 Top 3 — Act on now

| # | Action | Owner | Deadline | Severity |
|:-:|---|---|:-:|:-:|
| 1 | [Action — keep under 60 chars] | [Role/Name] | [YYYY-MM-DD] | 🔴 |
| 2 | [Action] | [Role/Name] | [YYYY-MM-DD] | 🔴 |
| 3 | [Action] | [Role/Name] | [YYYY-MM-DD] | 🔴 |

**Why these three:** [One sentence on the ranking logic — what made these top vs the rest.]

---

## 🧭 Triad positions

Where each role landed on each finding. `🔴 critical · 🟡 important · 🟢 suggestion · ✅ strong · ⚪ no opinion`

| Finding | PM | Design | Eng | Consensus |
|---|:-:|:-:|:-:|:-:|
| [Finding — keep concise] | 🔴 | 🟡 | 🔴 | 🔴 |
| [Finding] | 🔴 | 🟢 | 🟡 | 🔴 |
| [Finding] | 🟡 | 🔴 | 🔴 | 🔴 |
| [Finding] | 🟢 | 🟡 | 🟡 | 🟡 |
| [Strength — what works] | ✅ | ✅ | ✅ | ✅ |

---

## 🤔 Conflicts resolved

| Topic | PM position | Design position | Eng position | Resolution |
|---|---|---|---|---|
| [Topic — concise] | [Brief] | [Brief] | [Brief] | [What we're doing + 1-line why] |

*(Omit this section if no conflicts surfaced.)*

---

## 🔄 Decisions to supersede

| Prior decision | Date | Why it no longer holds | Suggested replacement |
|---|:-:|---|---|
| [Title from decisions.md] | [Date] | [Brief] | [New approach] |

*(Omit this section if no decisions need re-evaluation. Each row triggers the supersede sub-flow.)*

---

## 📋 Full findings (reference)

<details>
<summary>Expand to see all findings grouped by severity</summary>

**🔴 Critical (X)**
- [Finding] — flagged by [PM / Design / Eng]
- [Finding] — flagged by [PM / Design / Eng]

**🟡 Important (X)**
- [Finding] — flagged by [PM / Design / Eng]

**🟢 Suggestions (X)**
- [Finding] — flagged by [PM / Design / Eng]

**✅ Consensus — strengths**
- [Item agreed strong by all three]

</details>

---

## ⏭️ Next step

1. **Confirm Top 3** — assign owners and deadlines (if not already set)
2. **Run supersede sub-flow** for each row in the "Decisions to supersede" table
3. **Update artifacts:** I'll patch PRD / architecture / ai-rules to reflect accepted findings
4. **Log this review** to memory.md with outcomes
```

### Rules for the table content

- **Action column:** under 60 characters. Verb-first. ("Resolve broadcasting model" not "We need to figure out the broadcasting model").
- **Finding column:** under 70 characters. Noun-phrase or short sentence. ("Broadcasting model unresolved" not "There's an issue with how we'll broadcast to attendees").
- **Position cells:** ONE emoji only. No text inside cells. Use ⚪ if a role didn't weigh in.
- **Consensus column:** the severity of the *worst* role's position (most cautious wins). Three ✅ = unanimous strength.
- **Resolution column:** what we're actually doing + 1-line reasoning. No "we should consider" — be decisive.
- **Full findings section** is collapsed by default (using `<details>`). The tables ARE the report. The full findings are reference material.
