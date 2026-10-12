# Agent Shelf

This directory is the public Agent Shelf library.

- `skills/<name>/SKILL.md`: skills and supporting text files
- `instructions/<name>.md`: instructions as plain Markdown
- `shelf.toml`: application targets recorded by Agent Shelf

`~/.config/agent-shelf` links to this directory. Changes made in the
Agent Shelf library therefore appear in this dotfiles repository.
Editing the library does not automatically update Codex or KiroCrew;
review and apply each item in the app.

Keep only content suitable for a public repository here. Do not add
credentials, private work instructions, or machine-specific settings.
History and deployment backups stay in the app's private data directory.
Git commits and pushes are manual.
