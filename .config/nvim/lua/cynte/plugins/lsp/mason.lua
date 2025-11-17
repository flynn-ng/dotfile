return {
	"williamboman/mason.nvim",
	dependencies = {
		"williamboman/mason-lspconfig.nvim",
		"WhoIsSethDaniel/mason-tool-installer.nvim",
	},
	config = function()
		-- import mason
		local mason = require("mason")

		-- import mason-lspconfig
		local mason_lspconfig = require("mason-lspconfig")

		local mason_tool_installer = require("mason-tool-installer")

		-- enable mason and configure icons
		mason.setup({
			ui = {
				icons = {
					package_installed = "✓",
					package_pending = "➜",
					package_uninstalled = "✗",
				},
			},
		})

		mason_lspconfig.setup({
			-- list of servers for mason to install
			ensure_installed = {
				"ts_ls",
				"lua_ls",
				-- "golangci_lint_ls",
				-- "gopls",
				-- "rust_analyzer",
				-- "terraformls",
				-- "tflint",
				-- "biome",
				-- "pyright",
				-- "postgres_lsp",
			},
			automatic_installation = true,
		})

		mason_tool_installer.setup({
			ensure_installed = {
				-- "golangci-lint",
				"prettier",
				-- "stylua",
				"eslint_d",
				-- "nixpkgs-fmt",
				"js-debug-adapter",
				-- "isort",
				-- "black",
				-- "ruff",
			},
			automatic_installation = true,
		})
	end,
}
