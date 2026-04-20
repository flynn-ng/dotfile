vim.pack.add({
	"https://github.com/scottmckendry/cyberdream.nvim",
})

require("cyberdream").setup({
	transparent = true,
	hide_fillchars = true,
	terminal_colors = true,
	borderless_picker = false,
})

vim.cmd("colorscheme cyberdream")
