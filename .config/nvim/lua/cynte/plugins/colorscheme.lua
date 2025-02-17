return {
	"scottmckendry/cyberdream.nvim",
	lazy = false,
	priority = 1000,
	config = function()
		require("cyberdream").setup({
			transparent = true,
			hide_fillchars = true,
			terminal_colors = true,
			borderless_picker = false,
		})
		vim.cmd("colorscheme cyberdream")
	end,
}
