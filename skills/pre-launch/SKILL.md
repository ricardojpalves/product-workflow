---
name: pre-launch
description: Use when preparing to go public, onboard real users, or handle real user data for the first time. Runs a structured launch-readiness check covering code quality, infrastructure, security, and growth basics. Final step before a v1 launch.
---

# /pre-launch

## Overview

Launch-readiness checklist for vibe-coded products. Covers the gaps that consistently appear in real AI-built apps before they hit real users — not theoretical risks, but the things that actually break.

Run this before going public. It takes 30–60 minutes. It will find something.

## When to use
- Before sharing with real users for the first time
- Before posting to Product Hunt, Reddit, or any distribution channel
- After building for a while in private and feeling "almost ready"
- Before adding payments or handling sensitive user data

## When not to use
- Throwaway prototypes with no real users
- Internal tools with no sensitive data and no payments

## Checklist

Run each item and mark: ✅ PASS / ⚠️ NEEDS ATTENTION / ❌ FAIL / N/A

### Code quality
- [ ] **N+1 queries** — does any list view trigger one DB query per row? Silent until traffic arrives.
- [ ] **Context rot** — if the codebase is large (80+ components), have you scoped prompts to specific files? Broad context → AI makes mistakes in unrelated areas.
- [ ] **Duplicate logic** — is the same business logic implemented in more than one place? Pick one source of truth, delete the rest.
- [ ] **Error handling on critical flows** — payment, auth, data write. What happens when each fails? User should see a clear message, not a white screen.

### Infrastructure
- [ ] **Staging and prod are separated** — different Supabase project, different env vars, different Stripe keys.
- [ ] **Environment variables validated at startup** — if a required env var is missing, the app should fail loudly on boot, not silently mid-request.
- [ ] **Stress test at 10× expected traffic** — one viral post can multiply your current load by 100. Know your ceiling before it hits.

### Auth and data
- [ ] **RLS policies audited** — every Supabase table with user data has RLS enabled AND policies reference `auth.uid()`, not just `true`.
- [ ] **No exposed API keys in frontend code** — check browser network tab and bundle. Anything public-facing that includes a secret key is a live credential leak.
- [ ] **Rate limiting on auth endpoints** — login, password reset, email verification. Unprotected = brute-force target.

### Payments (skip if no payments)
- [ ] **Stripe webhook signature verification** — `stripe.webhooks.constructEvent()` with endpoint secret before any business logic. Without this, anyone can fake a payment.
- [ ] **Payment flow has test coverage** — run through the full checkout → webhook → feature unlock flow in Stripe test mode. At least once.
- [ ] **Race conditions in billing** — can a single-use coupon be redeemed twice via parallel requests? Test by hitting the endpoint simultaneously.

### Email
- [ ] **Supabase default SMTP replaced** — switch to Resend or Postmark. Default SMTP has terrible deliverability; transactional emails disappear silently.
- [ ] **SPF, DKIM, DMARC configured** — required for deliverability on any custom domain. Check with mail-tester.com.

### Growth basics
- [ ] **Onboarding email sequence** — at least 3 emails: welcome, activation tip, check-in. Activation rate without email: 12–18%. With a 3-email flow: 35–50%.
- [ ] **Error monitoring installed** — Sentry (or equivalent) configured before you share with anyone. First signal of a bug should be you, not an angry user.
- [ ] **Analytics installed** — PostHog, Umami, or equivalent. You need to know if users are reaching activation events.

### Security (summary)
- [ ] **`/security-audit` run** — for a full security pass (IDOR, webhook validation, secrets, CORS, CSP, injection, AI/LLM security, mobile security), run `/security-audit` as the final step before launch.

---

## Output format

```
🚀 Pre-Launch Check — [Project] — [Date]

✅ PASS (X items)
⚠️ NEEDS ATTENTION (X items) — listed below
❌ FAIL (X items) — listed below with fix

---
NEEDS ATTENTION:
• [Item] — [what to fix]

FAIL (fix before launch):
• [Item] — [exact file/location if identifiable] — [one-line fix]

---
TOP 3 FIXES before launch:
1. [Highest risk]
2. [Second]
3. [Third]

Ready to launch? [Yes / No — with reason]
```

## Common mistakes

| Mistake | Fix |
|---|---|
| Treating this as optional | Every item on this list came from a real app breaking in production |
| Running it the day of launch | Do it a week before — leaves time to fix things |
| Skipping payments section "because it's simple" | Race conditions in billing are invisible until exploited |
| Skipping `/security-audit` | This checklist covers operational readiness; security audit covers attack surface — they're different |
