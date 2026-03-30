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
-- return {
-- 	"Mofiqul/vscode.nvim",
-- 	lazy = false,
-- 	priority = 1000,
-- 	config = function()
-- 		require("vscode").setup({
-- 			transparent = true,
-- 			hide_fillchars = true,
-- 			terminal_colors = true,
-- 			borderless_picker = false,
-- 		})
-- 		vim.cmd("colorscheme vscode")
-- 	end,
-- }
