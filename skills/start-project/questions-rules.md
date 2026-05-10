# AI Rules Discovery Questions

These are the non-negotiables that the coding agent must respect throughout the build.

Ask in batches by domain. Offer baseline rules — user keeps, removes, or adds.

---

## Baseline rules (offer all by default; user opts in)

### Security baseline
- [ ] Secrets never hardcoded — `.env.local` (or Keychain for desktop)
- [ ] No API keys in client-side code
- [ ] All inputs validated at trust boundaries
- [ ] SQL queries parameterized
- [ ] CORS, CSP, rate limiting configured before public deploy

### Code quality baseline
- [ ] TypeScript strict mode
- [ ] No `any` types unless justified in comment
- [ ] Functions < 50 lines or split
- [ ] Components < 200 lines or split

### Performance baseline
- [ ] No N+1 queries
- [ ] Lazy-load heavy components
- [ ] Bundle size budget defined

### Accessibility baseline
- [ ] Semantic HTML
- [ ] Keyboard accessible
- [ ] WCAG AA color contrast
- [ ] Form inputs labeled

### Style baseline
- [ ] Use `DESIGN.md` tokens — no hardcoded colors/sizes
- [ ] Reuse existing components first

---

## Stack-specific rules

Ask which apply based on architecture answers:

**If iOS/SwiftUI:**
- SwiftUI only — no UIKit unless wrapping
- `@Observable` over `@ObservableObject`
- Keychain for secrets, never UserDefaults

**If React:**
- No prop drilling beyond 2 levels
- No useEffect for derived state — compute during render
- Server components by default in Next.js

**If Supabase:**
- All tables have RLS enabled before deploy
- Use migrations — no manual schema edits in production

---

## Project-specific rules

Ask:
"Are there any non-negotiables specific to this project? E.g. 'must work offline', 'no third-party scripts', 'GDPR compliance from day one', 'no analytics'?"

Add what user provides.

---

## Forbidden patterns

Ask:
"Anything this project will explicitly NOT do, regardless of how convenient?"

E.g. "Won't store user data on third-party servers", "Won't use AI on personal data", "Won't ship without tests for the auth flow"

---

## After all questions answered

1. Draft ai-rules.md using `templates/ai-rules.md`
2. Show to user
3. Trigger triad review (`triad-prompts.md`)
