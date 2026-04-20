local opt = vim.opt

opt.number = true
opt.relativenumber = true
opt.signcolumn = "yes"
opt.cursorline = true
opt.scrolloff = 16
opt.termguicolors = true
opt.laststatus = 3
opt.showmode = false
opt.wrap = false

opt.tabstop = 2
opt.shiftwidth = 2
opt.tabstop = 2
opt.softtabstop = 2
opt.expandtab = true
opt.smartindent = true
opt.autoindent = true

opt.ignorecase = true
opt.smartcase = true
opt.hlsearch = false
opt.incsearch = true

opt.splitright = true
opt.splitbelow = true
opt.undofile = true
opt.updatetime = 250
opt.timeoutlen = 300

opt.autocomplete = true
opt.completeopt = "menu,menuone,noselect"
opt.pumborder = "rounded"
opt.pummaxwidth = 40

opt.foldmethod = "expr"
opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
opt.foldlevel = 99

opt.clipboard:append("unnamedplus")
