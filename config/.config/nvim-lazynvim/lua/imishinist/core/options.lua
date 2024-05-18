vim.cmd("let g:netrw_liststyle = 3")

local opt = vim.opt

opt.shell = "fish"
opt.backupskip = "/tmp/*,/private/tmp/*"
opt.wildignore:append({ "*/node_modules/*" })
opt.undofile = true

-- file encoding
vim.scriptencoding = "utf-8"
opt.encoding = "utf-8"
opt.fileencoding = "utf-8"

opt.relativenumber = false
opt.number = true

-- command
opt.showcmd = true
opt.cmdheight = 1
opt.laststatus = 2

-- tabs & indentation
opt.tabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
opt.autoindent = true
opt.smartindent = true
opt.smarttab = true

opt.wrap = false

-- search settings
opt.ignorecase = true
opt.smartcase = true
opt.hlsearch = true

opt.cursorline = true

opt.termguicolors = true
opt.background = "dark"
opt.signcolumn = "yes"

opt.backspace = "indent,eol,start"

if vim.fn.has("macunix") == 1 then
  opt.clipboard:append("unnamedplus")
end

opt.splitright = true
opt.splitbelow = true

-- Turn off paste mode when leaving insert mode
vim.api.nvim_create_autocmd("InsertLeave", {
  pattern = "*",
  command = "set nopaste",
})

vim.cmd("autocmd BufRead, BufNewFile *.go set nocindent")

vim.api.nvim_create_autocmd({ "BufReadPost" }, {
  pattern = { "*" },
  callback = function()
    vim.api.nvim_exec('silent! normal! g`"zv', false)
  end,
})
