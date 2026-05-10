#!/usr/bin/env bash
# Installs product-workflow skills into ~/.claude/skills/
# Run from the repo root.

set -e

REPO_DIR="$(cd "$(dirname "$0")" && pwd)"
SKILLS_DIR="$HOME/.claude/skills"
CONFIG_DIR="$HOME/.claude"
CONFIG_FILE="$CONFIG_DIR/product-workflow.config.md"

echo "🚀 Installing product-workflow skills..."

# 1. Create skills dir if missing
mkdir -p "$SKILLS_DIR"

# 2. Symlink each skill (so updates in repo flow to ~/.claude/skills automatically)
for skill in start-project status code-audit triad-review; do
  src="$REPO_DIR/skills/$skill"
  dst="$SKILLS_DIR/$skill"

  if [ -L "$dst" ]; then
    echo "  ↻  $skill (existing symlink, updating)"
    rm "$dst"
  elif [ -d "$dst" ]; then
    echo "  ⚠️   $skill already exists as a directory — skipping (back it up and re-run)"
    continue
  fi

  ln -s "$src" "$dst"
  echo "  ✓  $skill → $dst"
done

# 3. Install config if not present
if [ ! -f "$CONFIG_FILE" ]; then
  cp "$REPO_DIR/config/start-project.config.md" "$CONFIG_FILE"
  echo "  ✓  Config installed at $CONFIG_FILE"
  echo "      → Edit it to match your paths and preferences"
else
  echo "  ↺  Config already exists at $CONFIG_FILE — leaving as-is"
fi

# 4. Post-install hints
echo ""
echo "✅ Installed. Available commands:"
echo "   /start-project    → Kick off a new project"
echo "   /status           → Project status snapshot"
echo "   /code-audit       → Independent code review by Codex"
echo "   /triad-review     → Mid-project PM + Design + Eng critique"
echo ""
echo "Next steps:"
echo "  1. Edit $CONFIG_FILE to set your paths"
echo "  2. (For /code-audit) Install Codex CLI — see https://platform.openai.com/docs"
echo "  3. Restart Claude Code or reload skills"
echo ""
