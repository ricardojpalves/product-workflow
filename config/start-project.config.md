# Product Workflow — User Config

Personal config for the product-workflow skills. Copy this to `~/.claude/product-workflow.config.md` and adjust.

---

## Paths

```yaml
# Where new projects are created by /start-project
projects-root: /Users/Local Projects/

# Where Obsidian Kanban boards live (per project subfolder)
kanban-root: /Users/Local Projects/Obsidian-Kanban/

# Where the product-workflow repo lives
workflow-repo: /Users/Local Projects/product-workflow/
```

## Defaults for /start-project

```yaml
# Default project type if user doesn't specify
default-project-type: solo  # solo | work

# Default stack (used as suggestion baseline in architecture questions)
default-stack:
  web:
    frontend: React + Vite + Tailwind + shadcn/ui
    backend: Supabase
    hosting: Vercel
  mobile:
    framework: Expo (React Native)
    backend: Supabase
  ios-native:
    framework: SwiftUI + SwiftData
```

## Defaults for /code-audit

```yaml
auditor: codex                    # codex | gemini | manual
focus:
  - security
  - rule-compliance
  - performance
severity-threshold: 🟡             # minimum to surface
auto-create-kanban-tasks: false    # always confirm first
```

## Defaults for /status

```yaml
default-mode: snapshot             # snapshot | spark | stakeholder
include-decisions-count: 5         # last N decisions
include-memory-count: 3            # last N memory entries
```

## Triad reviewers

```yaml
# All three are mandatory — don't disable individually
reviewers:
  - product-manager
  - designer
  - engineering-lead
```
