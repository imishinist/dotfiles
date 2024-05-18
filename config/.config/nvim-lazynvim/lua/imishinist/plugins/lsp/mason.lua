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
    mason_lspconfig.setup({
      ensure_installed = {
        "bashls",
        "bufls",
        "clangd",
        "gopls",
        "lua_ls",
        "rust_analyzer",
        "tsserver",
      },
    })
    mason_tool_installer.setup({
      ensure_installed = {
        "biome",
        "bash-language-server",
        "buf",
        "protolint",
        "buf-language-server",
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
