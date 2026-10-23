#!/usr/bin/env bash
# Link the skills in this folder into place. Re-run after adding or removing one by hand.
#
#   ~/.agents                -> dotfiles/agents                (npx skills, OpenCode, Codex)
#   ~/.claude/skills/<name>  -> dotfiles/agents/skills/<name>  (Claude Code)
#
# ~/.claude/skills stays a real directory, so what Claude Code writes there
# itself (synced/ claude.ai skills, .trash/) stays out of this repo.
set -euo pipefail

AGENTS_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CLAUDE_SKILLS="$HOME/.claude/skills"

if [[ -d "$HOME/.agents" && ! -L "$HOME/.agents" ]]; then
  echo "~/.agents is a real directory, move it aside first" >&2
  exit 1
fi
ln -sfn "$AGENTS_DIR" "$HOME/.agents"

[[ -L "$CLAUDE_SKILLS" ]] && rm "$CLAUDE_SKILLS" # older setups linked the whole directory
mkdir -p "$CLAUDE_SKILLS"

for skill in "$AGENTS_DIR"/skills/*/; do
  name=$(basename "$skill")
  [[ -e "$CLAUDE_SKILLS/$name" ]] || ln -s "${skill%/}" "$CLAUDE_SKILLS/$name"
done

# Drop links to skills that were removed.
find "$CLAUDE_SKILLS" -maxdepth 1 -type l ! -exec test -e {} \; -delete
