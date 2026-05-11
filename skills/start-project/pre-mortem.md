# Pre-Mortem — Risk Classification

Run AFTER PRD/Architecture/Rules are drafted but BEFORE triad review. Surfaces risks the user already half-knows so the triad can focus on bigger gaps.

---

## The framing

Ask the user:

> **Imagine it's 6 months from now. The project failed. What killed it?**
>
> Don't be polite — be specific. Surface 5–10 candidate failure modes.

If user is stuck, offer prompts to seed thinking:
- "What's the part of the PRD that feels least nailed down?"
- "What dependency are we trusting that might not deliver?"
- "What user behaviour are we assuming?"
- "What technical thing have we never built before?"
- "What stakeholder dynamic could go wrong?"

---

## The classification

Then classify each risk into one of three buckets:

| Bucket | Definition | What to do |
|---|---|---|
| 🐯 **Tiger** | High likelihood AND high impact | Act now — Phase 0 or top of Phase 1 |
| 📄 **Paper Tiger** | Looks scary but unlikely OR easily mitigated | Acknowledge + park · monitor |
| 🐘 **Elephant** | Slow-moving but will hit eventually if ignored | Schedule for later phase · don't ignore |

**Rules:**
- 🐯 Tigers MUST appear as actions in plan.md Phase 0 or Phase 1
- 📄 Paper Tigers are logged in plan.md "Risks" section with a one-line mitigation
- 🐘 Elephants are logged in plan.md "Risks" section with a target phase to address
- If unsure between Tiger and Paper Tiger → call it Tiger (cost of false-positive is low)

---

## Output format

Present as a table:

```markdown
## 🔍 Pre-mortem — Risk classification

| Risk | Bucket | Why | Action |
|---|:-:|---|---|
| [Risk description] | 🐯 | [Why high likelihood + high impact] | [Specific Phase 0/1 action] |
| [Risk description] | 📄 | [Why unlikely or easily mitigated] | [Monitor / single-line mitigation] |
| [Risk description] | 🐘 | [Why slow-moving] | [Which phase will address it] |
```

Show to user. Confirm classification.

---

## Hand-off to triad

Pass the pre-mortem table to the triad along with PRD/Architecture/Rules. Each role critiques:
- **PM:** Are the Tigers correctly classified? Any business risks missed?
- **Design:** Any UX risks misclassified as Paper Tigers?
- **Engineering:** Any technical Tigers hiding as Elephants?

Triad output's "Top 3 to act on now" should pull primarily from the 🐯 Tiger list.

---

## Common mistakes

| Mistake | Fix |
|---|---|
| Classifying every risk as Tiger | Forces no prioritisation. Push back. 3–5 Tigers max. |
| Skipping the "what killed it" framing | Specific failure modes > generic risks. The framing matters. |
| Treating Paper Tigers as "won't happen" | They CAN happen — they're just unlikely OR have an easy fix. Don't ignore. |
| Letting Elephants stay vague | Always assign a target phase. Otherwise they slip forever. |
