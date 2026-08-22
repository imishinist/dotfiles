return {
  "williamboman/mason.nvim",
  dependencies = {
    "williamboman/mason-lspconfig.nvim",
    "WhoIsSethDaniel/mason-tool-installer.nvim",
  },
  config = function()
    local mason = require("mason")

    local mason_lspconfig = require("mason-lspconfig")

    local mason_tool_installer = require("mason-tool-installer")

    mason.setup({
      ui = {
        icons = {
          package_installed = "✓",
          package_pending = "→",
          package_uninstalled = "✘",
        },
      },
    })
    -- Do not install missing language servers during editor startup.
    mason_lspconfig.setup({ automatic_enable = false })
    mason_tool_installer.setup({
      -- Do not turn a temporary network failure into a startup error.
      -- Run :MasonToolsInstall explicitly when tools should be updated.
      run_on_start = false,
      ensure_installed = {
        "biome",
        "bash-language-server",
        "buf-language-server",
        "protolint",
        "buf",
        "clang-format",
        "cfn-lint",
        "goimports",
        "golangci-lint",
        "rust-analyzer",
        "shellcheck",
        "stylua",
        "typescript-language-server",
        "pylint",
      },
    })
  end,
}
