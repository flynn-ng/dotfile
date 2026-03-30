return {
	"Exafunction/windsurf.nvim",
	-- build = ":Codeium Auth",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"hrsh7th/nvim-cmp",
	},
	config = function()
		require("codeium").setup({
			enable_cmp_source = false,
			virtual_text = {
				enabled = true,
				filetypes = {
					snacks_picker_input = false,
					snacks_input = false,
					NvimTree = false,
					-- ["Avante*"] = false,
				},
				key_bindings = {
					accept = "<C-c>",
					next = "<C-n>",
					prev = "<C-p>",
				},
			},
		})
	end,
}
