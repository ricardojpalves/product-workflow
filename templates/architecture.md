# Architecture — [Project Name]

**Last updated:** YYYY-MM-DD

---

## 1. Stack
Explicit technology choices. Locked unless ai-rules.md says otherwise.

| Layer | Choice | Reason |
|---|---|---|
| Frontend | [e.g. React + Vite + Tailwind] | [why] |
| Backend | [e.g. Supabase] | [why] |
| Database | [e.g. Postgres via Supabase] | [why] |
| Auth | [e.g. Supabase Auth] | [why] |
| Hosting | [e.g. Vercel] | [why] |
| Storage | [e.g. Supabase Storage] | [why] |
| Other | [e.g. Resend for email] | [why] |

## 2. Folder Structure

```
project-root/
├── src/
│   ├── components/        # Reusable UI components
│   ├── routes/            # Page-level components
│   ├── lib/               # Helpers, utils, clients
│   ├── hooks/             # Custom hooks
│   └── styles/            # Global styles, design tokens
├── public/                # Static assets
├── supabase/              # Migrations, edge functions
├── tests/                 # Test files
├── DESIGN.md              # Visual identity tokens
├── PRD.md
├── ai-rules.md
├── plan.md
├── memory.md
├── decisions.md
└── README.md
```

[Adjust based on the project. Document any non-obvious folders.]

## 3. Naming Conventions
- **Files:** `kebab-case.tsx` for components, `camelCase.ts` for utilities
- **Components:** `PascalCase`
- **Functions:** `camelCase`
- **Constants:** `UPPER_SNAKE_CASE`
- **Database tables:** `snake_case_plural` (e.g. `user_profiles`)
- **Database columns:** `snake_case`

## 4. Data Flow
How data moves through the app. One paragraph or simple diagram.

[Example: "User authenticates via Supabase Auth → JWT stored in cookie → frontend fetches user profile via Supabase client → data written via RLS-protected tables → no direct backend service layer."]

## 5. State Management
- **Server state:** [e.g. React Query / SWR]
- **Client state:** [e.g. Zustand / Context API]
- **Form state:** [e.g. React Hook Form]
- **URL state:** [e.g. search params for filters]

## 6. Key Architectural Decisions
Cross-reference major decisions to `decisions.md` for full rationale.

- [Decision title] — see decisions.md
- [Decision title] — see decisions.md

## 7. External Dependencies
Third-party services, APIs, libraries that the project depends on.

| Dependency | Purpose | Critical? |
|---|---|---|
| [Service] | [What it does] | Yes/No |

## 8. Deployment
- **Environments:** [dev, staging, production]
- **CI/CD:** [GitHub Actions auto-deploys to Vercel on merge to main]
- **Environment variables:** Listed in `.env.example`
- **Secrets:** [Where they live — Vercel env, Supabase, etc.]
