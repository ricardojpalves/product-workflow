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

## Q4.5 — Edge cases V1 must handle gracefully

**What happens when things go wrong?**

Examples to seed thinking:
- Network drops mid-action
- User input is unexpected (too large, malformed, empty, hostile)
- Third-party API rate-limited or down
- Browser tab killed mid-flow
- Permission denied (camera, location, file access)
- Concurrent users editing same thing

Ask the user to list 3–5 edge cases V1 must handle gracefully. These don't all need full solutions — but acknowledging them now prevents triad surprise and surfaces hidden complexity early.

**Recommendation framing:** "Most apps die from edge cases, not happy paths. Even a 1-line 'we show toast X' counts as a decision."

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

**Optional: hypothesis framing for exploratory metrics**

If a metric is more bet than commitment, phrase as a testable hypothesis:

> **We believe [X] because [Y]. We'll know we're right when [Z].**

Example:
> We believe webinar hosts will trigger 3+ overlays per meeting because they currently juggle multiple tools and want unified surface. We'll know we're right when median overlays-per-meeting is ≥3 by week 4.

Use when the success criterion is exploratory rather than locked. Doesn't replace quant/qual/anti-metric — sits alongside.

---

## Q5.5 — Distribution (all projects)

How will your first 100 users find this?

This question is asked before the plan locks — not after launch. Distribution that's treated as an afterthought after building is one of the most common causes of real products going nowhere. Vibe coders in particular lose months building in private and then discover nobody shows up.

**Probe if vague:** "Who's the first person outside your circle who uses this? How do they find it? What would make them share it?"

**Suggestions (tailor to Q1 + Q2):**
1. Community distribution — Reddit, Slack groups, Discord, forums where your target user already lives. Find the right room, help genuinely, mention the tool once.
2. Content distribution — SEO articles, AEO (Answer Engine Optimization), social posts, newsletter. Slower but compounds. Best when the problem is well-searched.
3. Direct outreach — email, LinkedIn, cold DMs to your target segment. Works fastest for B2B or when you can identify prospects precisely.
4. Product-led — free tier, virality hook, or embed into existing workflow so product sells itself.
5. Partnerships — piggyback on a larger platform, tool, or audience that already serves your segment.

**Recommendation framing:** Recommend the one most realistic given the user's context (solo? B2B? consumer?) and existing audience (do they have any?). If they have zero distribution assets: community first.

**Then ask:** "And what's your plan for the *first* 10 users — before any of the above matters?"

The answer to this often reveals whether the product is solving a real, findable problem.

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
