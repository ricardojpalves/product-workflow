#!/usr/bin/env bash
# Installs product-workflow skills for Claude Code, Codex CLI, or both.
# Run from the repo root.

set -e

REPO_DIR="$(cd "$(dirname "$0")" && pwd)"

# Detect which AI tools the user has set up
CLAUDE_DIR="$HOME/.claude"
CODEX_DIR="$HOME/.agents"
CLAUDE_SKILLS="$CLAUDE_DIR/skills"
CODEX_SKILLS="$CODEX_DIR/skills"

INSTALL_CLAUDE=false
INSTALL_CODEX=false

# Parse flags
for arg in "$@"; do
  case $arg in
    --claude) INSTALL_CLAUDE=true ;;
    --codex)  INSTALL_CODEX=true ;;
    --all)    INSTALL_CLAUDE=true; INSTALL_CODEX=true ;;
    --help|-h)
      echo "Usage: ./install.sh [--claude|--codex|--all]"
      echo ""
      echo "Without flags: auto-detects which tools are installed and installs to all found."
      echo "  --claude    Install for Claude Code only (~/.claude/skills/)"
      echo "  --codex     Install for Codex CLI only (~/.agents/skills/)"
      echo "  --all       Install for both"
      exit 0
      ;;
  esac
done

# Auto-detect if no flags provided
if [ "$INSTALL_CLAUDE" = false ] && [ "$INSTALL_CODEX" = false ]; then
  [ -d "$CLAUDE_DIR" ] && INSTALL_CLAUDE=true
  [ -d "$CODEX_DIR" ] && INSTALL_CODEX=true

  if [ "$INSTALL_CLAUDE" = false ] && [ "$INSTALL_CODEX" = false ]; then
    echo "⚠️  Neither ~/.claude nor ~/.agents found."
    echo "   Install Claude Code or Codex CLI first, or pass a flag explicitly:"
    echo "   ./install.sh --claude    # Force Claude Code install"
    echo "   ./install.sh --codex     # Force Codex CLI install"
    exit 1
  fi
fi

echo "🚀 Installing product-workflow skills..."
echo ""

install_to() {
  local target_dir="$1"
  local label="$2"

  mkdir -p "$target_dir"

  for skill in start-project status code-audit triad-review; do
    local src="$REPO_DIR/skills/$skill"
    local dst="$target_dir/$skill"

    if [ -L "$dst" ]; then
      rm "$dst"
      ln -s "$src" "$dst"
      echo "  ↻  [$label] $skill (updated symlink)"
    elif [ -d "$dst" ]; then
      echo "  ⚠️   [$label] $skill already exists as directory — skipping"
      continue
    else
      ln -s "$src" "$dst"
      echo "  ✓  [$label] $skill → $dst"
    fi
  done
}

if [ "$INSTALL_CLAUDE" = true ]; then
  echo "→ Installing for Claude Code"
  install_to "$CLAUDE_SKILLS" "Claude"

  CLAUDE_CONFIG="$CLAUDE_DIR/product-workflow.config.md"
  if [ ! -f "$CLAUDE_CONFIG" ]; then
    cp "$REPO_DIR/config/start-project.config.md" "$CLAUDE_CONFIG"
    echo "  ✓  [Claude] Config installed at $CLAUDE_CONFIG"
  else
    echo "  ↺  [Claude] Config already exists — leaving as-is"
  fi
  echo ""
fi

if [ "$INSTALL_CODEX" = true ]; then
  echo "→ Installing for Codex CLI"
  install_to "$CODEX_SKILLS" "Codex"

  CODEX_CONFIG="$CODEX_DIR/product-workflow.config.md"
  if [ ! -f "$CODEX_CONFIG" ]; then
    cp "$REPO_DIR/config/start-project.config.md" "$CODEX_CONFIG"
    echo "  ✓  [Codex] Config installed at $CODEX_CONFIG"
  else
    echo "  ↺  [Codex] Config already exists — leaving as-is"
  fi
  echo ""
fi

echo "✅ Installed. Available commands (type these in your AI coding tool):"
echo "   /start-project    → Kick off a new project"
echo "   /status           → Project status snapshot"
echo "   /code-audit       → Independent code review"
echo "   /triad-review     → Mid-project PM + Design + Eng critique"
echo ""
echo "Next steps:"
[ "$INSTALL_CLAUDE" = true ] && echo "  • Edit ~/.claude/product-workflow.config.md to set your paths"
[ "$INSTALL_CODEX" = true ]  && echo "  • Edit ~/.agents/product-workflow.config.md to set your paths"
echo "  • (For /code-audit) Install Codex CLI if you haven't: https://platform.openai.com/docs"
echo "  • Restart your AI coding tool to load skills"
echo ""
