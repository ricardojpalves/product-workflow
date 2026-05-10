# PRD Discovery Questions

Ask one at a time. Each with grounded suggestions. Order matters — earlier answers ground later suggestions.

---

## Q1 — Why does this exist?

The strategic rationale. Why does this exist? What does it complement, replace, or unlock?

**Probe if vague:** "What happens if you don't build this?"

**Suggestions to offer (tailor based on opening brain-dump):**
1. Complement an existing product/business — extend a current line, retain users, defend market position
2. Standalone consumer/indie play — direct-to-user, monetised via subscription / freemium / one-time
3. Internal tool — solves your own workflow pain
4. B2B / API / developer tool — sell to other builders or businesses

Recommend the one that best matches the brain-dump. State why.

---

## Q2 — Who exactly is this for?

Be specific. Specificity is what separates useful AI output from garbage.

**Probe if vague:** "Can you narrow that further? Top 10%, bottom 10%, middle? Beginners or experts? Which sub-segment?"

**Follow-up:** "And who is this explicitly *not* for?"

**Suggestions to offer (must be tailored to Q1 answer):**
- Suggest 3 specific segments with reasoning
- Highlight the trade-off between narrow and broad
- Recommend the wedge: usually the most-underserved sub-segment

---

## Q3 — What's the problem you're solving?

What do users actually do today, and why is that bad? Frame as observed behaviour, not assumption.

**Probe if vague:** "What do they do right now instead? Why isn't that working? What pain do they feel?"

**Suggestions:**
- Surface 3 candidate problems based on the user segment + Q1
- For each: phrase as observed behaviour ("X currently does Y, which leads to Z")
- Recommend the one that's most defensible / differentiated

---

## Q4 — Key Elements (V1)

What are the 3–5 things V1 must do? Phrase as user outcomes, not features.

**Suggestions:**
- Propose 5 candidate elements based on Q3 problem
- Recommend the minimum viable set that delivers on the promise
- The rest become "Out of Scope V1"

**Then ask immediately:**
"What's tempting that you're going to *not* build in V1, and why not yet?"

This populates the Scope Table.

---

## Q5 — Success Criteria

How will you know V1 is working?

**Probe:**
- "Done when:" — concrete shipping bar
- "Good when:" — quality bar
- "Anti-metric:" — what would alarm you?

**Suggestions:**
- Mix quant + qual
- Always include at least one anti-metric (signal of misuse / bad outcome)

---

## Q6 (work projects only) — RACI

Who plays each role? Be specific with names.

- **R — Responsible:** Executes the work
- **A — Accountable:** Singular decision-maker
- **C — Consulted:** Provides input, validation
- **I — Informed:** Kept up to date

---

## After all questions answered

1. Draft the PRD using `templates/PRD-solo.md` or `templates/PRD-work.md`
2. Show to user: "Here's what I heard. Anything missing or wrong?"
3. Refine until user confirms
4. Move to architecture discovery (`questions-architecture.md`)
