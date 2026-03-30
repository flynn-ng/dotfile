return {
	"nvim-treesitter/nvim-treesitter",
	event = { "BufReadPre", "BufNewFile" },
	build = ":TSUpdate",
	dependencies = {
		"windwp/nvim-ts-autotag",
	},
	config = function()
		local configs = require("nvim-treesitter")
		configs.install({
			"json",
			"javascript",
			"typescript",
			"yaml",
			"toml",
			"html",
			"css",
			"bash",
			"lua",
			"vim",
			"dockerfile",
			"gitignore",
			"vimdoc",
			"sql",
			"go",
			"rust",
			"tsx",
			"regex",
			"python",
			"nix",
			"yaml",
			"java",
		})
		vim.api.nvim_create_autocmd("FileType", {
			pattern = { "javascript", "typescript", "lua", "python", "go", "rust", "tsx", "html", "css", "java" },
			callback = function()
				vim.treesitter.start()
				-- Use Treesitter for indentation
				vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
			end,
		})
		require("nvim-ts-autotag").setup({})
	end,
}
