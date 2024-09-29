return {
	"EdenEast/nightfox.nvim",
	priority = 1000,
	config = function()
		require("nightfox").setup({
			options = {
				transparent = true,
			},
		})
		vim.cmd("colorscheme Carbonfox")
	end,
}
-- return {
-- 	"0xstepit/flow.nvim",
-- 	lazy = false,
-- 	priority = 1000,
-- 	opts = {},
-- 	config = function()
-- 		require("flow").setup_options({
-- 			transparent = false,
-- 			fluo = "orange",
-- 			mode = "normal",
-- 			aggressive_spell = false,
-- 		})
--
-- 		vim.cmd("colorscheme flow")
-- 	end,
-- }
