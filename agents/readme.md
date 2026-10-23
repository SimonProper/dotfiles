# Agent skills

One skills directory shared by Claude Code, OpenCode and Codex, version
tracked here so every machine gets the same set.

```
agents/
  skills/            one folder per skill, each with a SKILL.md
  .skill-lock.json   written by `npx skills`, records where third-party skills came from
  setup.sh           links the tools at this directory
  readme.md
```

## Setup on a new machine

```shell
~/dotfiles/agents/setup.sh
```

This links `~/.agents` to this folder (the `npx skills` hub, also read by
OpenCode and Codex) and puts one symlink per skill in `~/.claude/skills`.
That directory stays a real one owned by Claude Code, so the claude.ai
skills it syncs (`synced/`) and its `.trash/` stay out of this repo. Re-run
it after adding or removing a skill by hand; it links new ones and drops
links to deleted ones. Restart any running agent afterwards, they scan for
skills on start.

The nono sandbox profiles in `../nono/profiles/` grant the agents both
`$HOME/.agents` and `$XDG_CONFIG_HOME/agents`, so the link and its target
are both reachable from inside the sandbox.

## Writing your own skill

Create a folder with a `SKILL.md` and commit it:

```shell
mkdir ~/dotfiles/agents/skills/my-skill
$EDITOR ~/dotfiles/agents/skills/my-skill/SKILL.md
```

The file needs a frontmatter block with `name` and `description`. The
description is what the agent reads to decide when to load the skill, so
say what it does and when to use it. Extra files (reference docs, scripts)
go in the same folder and are referenced from the SKILL.md.

```markdown
---
name: my-skill
description: What it does. Use when the user asks for X or mentions Y.
---

Instructions go here.
```

Run `setup.sh` to link the new skill for Claude Code, then restart the
agent.

## Third-party skills

Install with the skills CLI. With `-g` it writes into `~/.agents/skills`,
which is this directory, and records the source in `.skill-lock.json`:

```shell
npx skills add <owner>/<repo> -g             # pick skills from a repo
npx skills add emilkowalski/skill -g -y      # install everything it offers
npx skills list -g                           # what is installed
npx skills check                             # which have upstream updates
npx skills update                            # pull those updates
npx skills remove <name> -g
```

Always pass `-g`. Without it the CLI installs into the current project
(`./.agents/skills`, `./.claude/skills`) instead of here. Don't pass
`--copy` either: that puts a real copy in `~/.claude/skills` instead of a
link back to this folder.

Run any of these, review `git diff`, and commit. The CLI also symlinks
each skill into `~/.claude/skills` itself, the same link `setup.sh` makes.

Both hand-written and installed skills are committed as plain files, so
another machine gets them with `git pull` and needs no `npx skills` run.
The lockfile only matters when you want to update from upstream.

## Where each tool looks

- Claude Code: `~/.claude/skills/<name>/SKILL.md` (linked per skill, see above), plus `.claude/skills/` in a project.
- OpenCode: `~/.config/opencode/skills/`, `~/.claude/skills/`, `~/.agents/skills/`, and the project-level equivalents. With `XDG_CONFIG_HOME` set to this repo, `../opencode/skills/` is also read, but nono generates absolute symlinks there so it stays gitignored.
- Codex: `~/.codex/skills/` and `~/.agents/skills/`, plus `.agents/skills/` in a project.

Project-scoped skills belong in the project, not here.
