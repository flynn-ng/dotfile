vim.cmd("let g:netrw_liststyle = 3")
vim.cmd("let g:loaded_perl_provider = 0")
vim.cmd("let g:loaded_ruby_provider = 0")
-- Set transparency for floating windows
vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
vim.api.nvim_set_hl(0, "FloatBorder", { bg = "none" })
vim.cmd("highlight! link NoicePopupBorder TelescopeBorder")
vim.cmd("highlight! link NoicePopupmenuBorder TelescopeBorder")
vim.cmd("highlight! link NoiceSplitBorder TelescopeBorder")

local opt = vim.opt
opt.relativenumber = true
opt.number = true

opt.tabstop = 2
opt.shiftwidth = 2
opt.tabstop = 2
opt.softtabstop = 2
opt.expandtab = true
opt.autoindent = true
opt.smartindent = true

opt.wrap = true

opt.scrolloff = 8

opt.hlsearch = false
opt.incsearch = true

opt.ignorecase = true
opt.smartcase = true

opt.cursorline = true

opt.termguicolors = true
opt.background = "dark"
opt.signcolumn = "yes"

opt.backspace = "indent,eol,start"

opt.clipboard:append("unnamedplus")

opt.splitright = true
opt.splitbelow = true

opt.laststatus = 3

opt.swapfile = false
