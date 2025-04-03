return {
	"yetone/avante.nvim",
	event = "VeryLazy",
	lazy = false,
	version = false,
	opts = {
		provider = "gemini",
		auto_suggestions_provider = "gemini",
		cursor_applying_provider = "gemini",
		gemini = {
			model = "gemini-2.0-flash",
			timeout = 30000,
			temperature = 0,
			max_tokens = 4096,
		},
		behaviour = {
			auto_suggestions = false,
			auto_set_highlight_group = true,
			enable_cursor_planning_mode = true,
		},
		web_search_engine = {
			provider = "tavily", -- tavily, serpapi, searchapi, google or kagi
		},
		mappings = {
			suggestion = {
				accept = "<Tab>",
			},
		},
	},
	build = "make",
	dependencies = {
		"nvim-treesitter/nvim-treesitter",
		"stevearc/dressing.nvim",
		"nvim-lua/plenary.nvim",
		"MunifTanjim/nui.nvim",
		--- The below dependencies are optional,
		"echasnovski/mini.pick", -- for file_selector provider mini.pick
		"nvim-telescope/telescope.nvim", -- for file_selector provider telescope
		"hrsh7th/nvim-cmp", -- autocompletion for avante commands and mentions
		"ibhagwan/fzf-lua", -- for file_selector provider fzf
		"nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
		-- "zbirenbaum/copilot.lua", -- for providers='copilot'
		{
			-- support for image pasting
			"HakonHarnes/img-clip.nvim",
			event = "VeryLazy",
			opts = {
				-- recommended settings
				default = {
					embed_image_as_base64 = false,
					prompt_for_file_name = false,
					drag_and_drop = {
						insert_mode = true,
					},
					-- required for Windows users
					use_absolute_path = true,
				},
			},
		},
		{
			"OXY2DEV/markview.nvim",
			lazy = false,
			enabled = true,
			ft = { "markdown", "norg", "rmd", "org", "vimwiki", "Avante" },
			opts = {
				previews = { "markdown", "norg", "rmd", "org", "vimwiki", "Avante" },
				max_length = 99999,
			},
		},
	},
}
