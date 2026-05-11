# Installation

## Prerequisites

- macOS or Linux (Windows via WSL should work, untested)
- One of: [Claude Code](https://claude.com/claude-code) or [Codex CLI](https://platform.openai.com/docs)
- Bash or Zsh
- (Recommended) Codex CLI for `/code-audit` (the adversarial reviewer)
- (Optional) [Obsidian](https://obsidian.md/) with the Kanban plugin — for visual status tracking

---

## Quick install

```bash
git clone https://github.com/ricardojpalves/product-workflow.git
cd product-workflow
./install.sh
```

The install script:
1. Auto-detects whether you have Claude Code (`~/.claude/`) or Codex CLI (`~/.agents/`) — installs to whichever it finds, or both
2. Symlinks each skill (so `git pull` updates flow automatically)
3. Copies the starter config (only if not present)
4. Prints next steps

Force a specific install with flags:

```bash
./install.sh --claude     # Claude Code only
./install.sh --codex      # Codex CLI only
./install.sh --all        # Force both
```

Then **restart your AI coding tool** so skills are picked up.

---

## Manual install (if you don't want symlinks)

If you prefer copies over symlinks:

```bash
cp -r skills/start-project ~/.claude/skills/
cp -r skills/status ~/.claude/skills/
cp -r skills/code-audit ~/.claude/skills/
cp -r skills/triad-review ~/.claude/skills/
cp config/start-project.config.md ~/.claude/product-workflow.config.md
```

Trade-off: copies don't auto-update when you `git pull` the repo.

---

## Configure

Edit `~/.claude/product-workflow.config.md`:

```yaml
# Where new projects are created
projects-root: /path/to/your/projects/

# Where Obsidian Kanban boards live
kanban-root: /path/to/your/obsidian/Kanban/

# Default project type (solo or work)
default-project-type: solo

# Code audit settings
auditor: codex             # codex | gemini | manual
severity-threshold: 🟡     # minimum to surface
```

The skills read this file automatically.

---

## Set up Codex CLI (for `/code-audit`)

`/code-audit` uses Codex CLI by default. If you don't install it, you can:
- Use Gemini CLI as fallback (set `auditor: gemini` in config)
- Use manual paste mode (set `auditor: manual`)

To install Codex CLI: see [OpenAI Codex CLI docs](https://platform.openai.com/docs).

After installing:

```bash
codex --version
codex auth login   # if needed
```

---

## Set up Obsidian Kanban (for visual status)

Optional but recommended. Steps:

1. Install [Obsidian](https://obsidian.md/)
2. Open your projects folder as a vault (or create a dedicated vault)
3. Install the **Kanban** community plugin (Settings → Community plugins → Browse → Kanban)
4. Set `kanban-root` in your config to that folder

`/start-project` will create a kanban board in `<kanban-root>/<project-name>/<project-name>-board.md` automatically.

---

## Verify install

In Claude Code, type:

```
/start-project
```

If the skill loads and starts asking discovery questions, you're set.

For `/code-audit`:

```
/code-audit
```

If Codex CLI isn't installed, it'll fall back to manual paste mode and tell you.

---

## Updating

If you installed via symlinks (recommended):

```bash
cd path/to/product-workflow
git pull
```

Updates flow automatically. Restart Claude Code to pick up SKILL.md changes.

---

## Uninstalling

```bash
rm ~/.claude/skills/start-project
rm ~/.claude/skills/status
rm ~/.claude/skills/code-audit
rm ~/.claude/skills/triad-review
rm ~/.claude/product-workflow.config.md
```

(Symlinks are safe to `rm` — they don't delete the source.)

---

## Troubleshooting

**Skills don't show up after install.**
→ Restart Claude Code. Skills are loaded at startup.

**`/start-project` complains about missing config.**
→ Check `~/.claude/product-workflow.config.md` exists. Re-run `./install.sh`.

**`/code-audit` says "Codex CLI not installed".**
→ Either install Codex CLI, or set `auditor: gemini` (or `manual`) in config.

**Triad review takes forever.**
→ Three subagents run in parallel — each can take 30s–2min. If much longer, check your Claude Code rate limits.
