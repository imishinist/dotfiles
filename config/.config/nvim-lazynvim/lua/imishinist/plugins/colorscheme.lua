return {
  "folke/tokyonight.nvim",
  priority = 1000,
  config = function()
    require("tokyonight").setup({
      style = "night",
      on_colors = function(color)
      end
    })
    vim.cmd("colorscheme tokyonight")
  end
}
