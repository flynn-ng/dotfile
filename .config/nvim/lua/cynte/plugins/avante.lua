return {
	"yetone/avante.nvim",
	event = "VeryLazy",
	lazy = false,
	version = false,
	opts = {
		-- system_prompt = function()
		-- 	local hub = require("mcphub").get_hub_instance()
		-- 	return hub and hub:get_active_servers_prompt() or ""
		-- end,
		-- Using function prevents requiring mcphub before it's loaded
		-- custom_tools = function()
		-- 	return {
		-- 		require("mcphub.extensions.avante").mcp_tool(),
		-- 	}
		-- end,
		context_window = 2048,
		instructions_file = "avante.md",
		provider = "gemini",
		-- provider = "groq",
		providers = {
			-- groq = {
			-- 	__inherited_from = "openai",
			-- 	api_key_name = "GROQ_API_KEY",
			-- 	endpoint = "https://api.groq.com/openai/v1",
			-- 	model = "llama-3.1-8b-instant",
			-- 	max_tokens = 512,
			-- 	extra_request_body = {
			-- 		max_completion_tokens = 512,
			-- 	},
			-- },
			gemini = {
				model = "gemini-2.5-flash-lite",
				timeout = 30000,
				max_tokens = 1048576,
				return_text = true,
				use_ReAct_prompt = false,
				extra_request_body = {
					generationConfig = {
						temperature = 0,
					},
				},
			},
		},
		auto_suggestions_provider = "gemini",
		web_search_engine = {
			provider = "tavily",
		},
		mappings = {
			suggestion = {
				accept = "<Tab>",
			},
		},
	},
	build = "make",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"MunifTanjim/nui.nvim",
		"echasnovski/mini.pick",
		"nvim-telescope/telescope.nvim",
		"hrsh7th/nvim-cmp",
		"ibhagwan/fzf-lua",
		"stevearc/dressing.nvim",
		"folke/snacks.nvim",
		"nvim-tree/nvim-web-devicons",
		{
			"HakonHarnes/img-clip.nvim",
			event = "VeryLazy",
			opts = {
				default = {
					embed_image_as_base64 = false,
					prompt_for_file_name = false,
					drag_and_drop = {
						insert_mode = true,
					},
					use_absolute_path = true,
				},
			},
		},
		{
			"MeanderingProgrammer/render-markdown.nvim",
			opts = {
				file_types = { "markdown", "Avante" },
			},
			ft = { "markdown", "Avante" },
		},
	},
}
