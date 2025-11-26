return {
	"Exafunction/codeium.nvim",
	build = ":Codeium Auth",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"hrsh7th/nvim-cmp",
	},
	opts = {
		enable_cmp_source = false,
		virtual_text = {
			enabled = true,
			key_bindings = {
				accept = "<C-c>",
				next = "<C-n>",
				prev = "<C-p>",
			},
		},
	},
}
