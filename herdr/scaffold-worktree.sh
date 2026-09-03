#!/bin/sh
# Create a worktree workspace with its four role tabs.
#
# usage: scaffold-worktree.sh <branch> [base-ref]

set -eu

Herdr=/opt/homebrew/bin/herdr
Jq=/usr/bin/jq
Trees=/Users/simon/Developer/Endra/worktree
Roles="nvim claude dev extra"

branch="${1:?usage: scaffold-worktree.sh <branch> [base-ref]}"
base="${2:-main}"
path="$Trees/$branch"

workspace=$("$Herdr" worktree create --branch "$branch" --base "$base" \
                --path "$path" --label "$branch" --focus |
            "$Jq" -r '.result.workspace.workspace_id // .result.workspace_id // empty')
[ -n "$workspace" ] ||
    workspace=$("$Herdr" pane current | "$Jq" -r '.result.pane.workspace_id')

# Reuse the tab herdr created with the workspace, then add the rest
spare=$("$Herdr" tab list --workspace "$workspace" | "$Jq" -r '.result.tabs[0].tab_id // empty')
for role in $Roles; do
    if [ -n "$spare" ]; then
        "$Herdr" tab rename "$spare" "$role" >/dev/null
        spare=
    else
        "$Herdr" tab create --workspace "$workspace" --label "$role" --no-focus >/dev/null
    fi
done

printf '%s  %s\n' "$workspace" "$path"
