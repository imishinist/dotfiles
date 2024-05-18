return {
  "lukas-reineke/indent-blankline.nvim",
  -- workaround: https://github.com/lukas-reineke/indent-blankline.nvim/discussions/692
  commit = "29be0919b91fb59eca9e90690d76014233392bef",
  event = { "BufReadPre", "BufNewFile" },
  main = "ibl",
  opts = {
    indent = {
      char = "│",
      tab_char = "│",
    },
    scope = { show_start = false, show_end = false },
    exclude = {
      filetypes = {
        "help",
        "alpha",
        "dashboard",
        "neo-tree",
        "Trouble",
        "trouble",
        "lazy",
        "mason",
        "notify",
        "toggleterm",
        "lazyterm",
      },
    },
  },
}
