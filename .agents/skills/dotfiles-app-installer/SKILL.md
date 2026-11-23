---
name: dotfiles-app-installer
description: Add requested macOS applications to this dotfiles repository's mitamae and Homebrew configuration and install them. Use when an application installation should remain reproducible in dotfiles.
---

# Dotfiles App Installer

Keep application installation reproducible in the repository while installing only what the user requested.

## Workflow

1. Work from the dotfiles repository root containing `roles/`, `cookbooks/`, and `bin/check`. Inspect `roles/darwin/default.rb`, `cookbooks/brew.rb`, nearby application entries, and existing changes before editing.
2. Check whether the application is already declared or installed, then confirm its canonical Homebrew package name. Use a cask for a macOS GUI application and a formula for a command-line tool, unless an existing cookbook provides a more suitable installation method.
3. Add or update the smallest declaration matching the surrounding style. A simple Homebrew package belongs in the existing macOS role; create a cookbook only when configuration or platform-specific logic requires one. For example:

   ```ruby
   brew 'package-name' do
     cask true
   end
   ```

   For a formula, use `brew 'package-name'` without the cask block. Preserve unrelated entries and changes.
4. If installation is requested, install the target package with `brew install --cask package-name` or `brew install --formula package-name`, skipping installation when it is already present. Use an existing dedicated cookbook when applicable. Applying `bin/mitamae local roles/darwin/default.rb` also affects other system configuration; use the full role only when that broader application is authorized. Follow the environment's approval requirements for writes outside the workspace and network access. If the user requests configuration changes only, stop after editing and validation.
5. Run `bin/check` from the repository root. For an installation, also verify the package with `brew list --cask package-name` or `brew list --formula package-name`, and check the executable or application bundle when useful. Report the declaration changed, installation status, and validation results.
