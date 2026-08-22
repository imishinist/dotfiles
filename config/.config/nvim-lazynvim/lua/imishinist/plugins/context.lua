return {
  "osyo-manga/vim-precious",
  dependencies = { "Shougo/context_filetype.vim" },
  init = function()
    -- The outer-region switcher uses syntax highlighting APIs that are
    -- incompatible with Neovim 0.11. Keep the filetype switchers enabled.
    vim.g.precious_enable_switchers = { outer_region = 0 }
  end,
}
