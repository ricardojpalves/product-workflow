# AI Rules — [Project Name]

**Last updated:** YYYY-MM-DD

These are non-negotiables. The coding agent must respect them. Violations are critical issues.

---

## Security
- [ ] Secrets never hardcoded — use `.env.local` (and Keychain/secure storage for desktop apps)
- [ ] No API keys in client-side code
- [ ] All inputs validated at trust boundaries (user input, external APIs)
- [ ] SQL queries parameterized (no string concatenation)
- [ ] CORS, CSP, and rate limiting configured before public deploy
- [ ] [Project-specific security rule]

## Authentication & Authorization
- [ ] Use [chosen auth provider] — no rolling our own
- [ ] Row Level Security (RLS) on all user-data tables
- [ ] Tokens stored in [secure storage / httpOnly cookie / Keychain]
- [ ] [Project-specific auth rule]

## Code Quality
- [ ] TypeScript strict mode enabled
- [ ] No `any` types unless justified in a comment
- [ ] No commented-out code in commits
- [ ] Functions under ~50 lines or split
- [ ] Components under ~200 lines or split
- [ ] [Project-specific quality rule]

## Performance
- [ ] No N+1 queries
- [ ] Lazy-load images and heavy components
- [ ] Bundle size budget: [target]
- [ ] Initial page load: [target]
- [ ] [Project-specific perf rule]

## Accessibility
- [ ] Semantic HTML (no div soup)
- [ ] All interactive elements keyboard-accessible
- [ ] Color contrast meets WCAG AA
- [ ] Form inputs have labels
- [ ] [Project-specific a11y rule]

## Testing
- [ ] Critical paths have integration tests
- [ ] Tests use real database (not mocks) for data-layer code
- [ ] [Project-specific testing rule]

## Style & Design
- [ ] Use design tokens from `DESIGN.md` — no hardcoded colors or sizes
- [ ] Reuse existing components before creating new ones
- [ ] [Project-specific design rule]

## Stack-specific Rules
[Add rules specific to your stack. Examples below — delete what doesn't apply.]

### React
- [ ] No prop drilling beyond 2 levels — use context or composition
- [ ] No useEffect for derived state — compute during render
- [ ] Server components by default in Next.js, client only when needed

### iOS / Swift
- [ ] SwiftUI only — no UIKit unless wrapping
- [ ] Use `@Observable` over `@ObservableObject`
- [ ] Use Keychain for secrets, never UserDefaults

### Supabase
- [ ] All tables have RLS enabled before deploy
- [ ] Use migrations for schema changes — no manual edits in production
- [ ] Edge Functions for sensitive operations only

## Forbidden Patterns
Things this project will not do, regardless of how convenient.

- ❌ [Pattern] — [why]
- ❌ [Pattern] — [why]

## Required Patterns
Things this project must always do.

- ✅ [Pattern] — [why]
- ✅ [Pattern] — [why]
