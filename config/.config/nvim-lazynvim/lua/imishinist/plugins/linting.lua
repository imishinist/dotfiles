return {
  "mfussenegger/nvim-lint",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local lint = require("lint")

    lint.linters_by_ft = {
      javascript = { "biomejs" },
      javascriptreact = { "biomejs" },
      typescript = { "biomejs" },
      typescriptreact = { "biomejs" },
      sh = { "shellcheck" },
      bash = { "shellcheck" },
    }

    local function lint_available()
      local names = lint.linters_by_ft[vim.bo.filetype] or {}
      local available = {}

      for _, name in ipairs(names) do
        local linter = lint.linters[name]
        local command = linter and linter.cmd
        if type(command) == "function" then
          local ok, resolved = pcall(command)
          command = ok and resolved or nil
        end
        if type(command) == "string" and vim.fn.executable(command) == 1 then
          table.insert(available, name)
        end
      end

      if #available > 0 then
        lint.try_lint(available)
      end
    end

    local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })
    vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
      group = lint_augroup,
      callback = lint_available,
    })

    vim.keymap.set("n", "<leader>l", lint_available, { desc = "Lint current file" })
  end,
}
