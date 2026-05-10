# Architecture Discovery Questions

Ask one at a time. Pull defaults from user's `~/.claude/CLAUDE.md` if it exists.

---

## Q1 — Platform

Where does this run?

**Suggestions:**
1. Web (responsive) — fastest to ship, broadest reach
2. Mobile native (iOS / Android / both) — best UX for mobile-first use cases
3. Mobile cross-platform (Expo / React Native) — one codebase, two stores
4. Desktop (macOS native / cross-platform) — for power users
5. CLI / API — for developer tools

Recommend based on PRD target user.

---

## Q2 — Frontend

For each platform, what stack?

**Web suggestions:**
- React + Vite + Tailwind + shadcn/ui (default for solo)
- Next.js if you need SSR / routing / API routes
- Svelte / SvelteKit if user already prefers it

**Mobile suggestions:**
- Expo (React Native) — solo cross-platform default
- SwiftUI for iOS-only

Recommend based on user's CLAUDE.md preferences.

---

## Q3 — Backend & data

What backend?

**Suggestions:**
1. Supabase — Postgres + Auth + Storage, fastest for solo (default)
2. Firebase — if real-time is critical
3. Custom (Node + Postgres) — if specific needs
4. None / static — if no server needed

---

## Q4 — Auth

How do users log in?

**Suggestions:**
1. Email + magic link via Supabase Auth — simplest, no passwords
2. OAuth (Google, GitHub, Apple) — frictionless if user already has those
3. None (anonymous / device-id) — for simple tools
4. Username + password — only if explicitly required

Flag: passwords carry security burden. Recommend against if avoidable.

---

## Q5 — Folder structure

Default structure documented in `templates/architecture.md`. Ask if user wants to adjust.

Most projects accept the default. Offer adjustments only if the project type warrants it (e.g. monorepo).

---

## Q6 — Hosting & deployment

**Suggestions:**
1. Vercel (web) — auto-deploy from GitHub, zero config
2. Cloudflare Pages — alternative
3. Expo EAS (mobile) — for store builds
4. App Store / Play Store directly (native)

---

## Q7 — Naming conventions & style

Default conventions documented in template. Confirm or adjust:
- Files: `kebab-case.tsx` for components, `camelCase.ts` for utils
- Components: `PascalCase`
- DB tables: `snake_case_plural`

---

## After all questions answered

1. Draft architecture.md using `templates/architecture.md`
2. Show to user
3. Move to ai-rules discovery (`questions-rules.md`)
