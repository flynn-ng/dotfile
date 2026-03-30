return {
	"stevearc/conform.nvim",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local conform = require("conform")

		conform.setup({
			formatters_by_ft = {
				javascript = { "prettierd" },
				typescript = { "prettierd", "eslint_d" },
				javascriptreact = { "prettierd" },
				typescriptreact = { "prettierd" },
				html = { "prettierd" },
				json = { "prettierd" },
				yaml = { "prettierd" },
				markdown = { "prettierd" },
				lua = { "stylua" },
				nix = { "nixpkgs_fmt" },
				python = { "isort", "black" },
				sql = { "sqruff", "sql_formatter" },
				mysql = { "sqruff", "sql_formatter" },
			},
			format_on_save = {
				lsp_fallback = true,
				async = false,
				timeout_ms = 500,
			},
		})

		vim.keymap.set({ "n", "v" }, "<leader>mp", function()
			conform.format({
				lsp_fallback = true,
				async = false,
				timeout_ms = 2000,
			})
		end, { desc = "Format file or range (in visual mode)" })
	end,
}
