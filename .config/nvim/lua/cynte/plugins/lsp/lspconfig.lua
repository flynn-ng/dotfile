return {
	"hrsh7th/cmp-nvim-lsp",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		{ "antosha417/nvim-lsp-file-operations", config = true },
	},
	config = function()
		vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
		vim.api.nvim_set_hl(0, "FloatBorder", { bg = "none" })

		-- Set diagnostic signs using the modern approach
		vim.diagnostic.config({
			signs = {
				text = {
					[vim.diagnostic.severity.ERROR] = " ",
					[vim.diagnostic.severity.WARN] = " ",
					[vim.diagnostic.severity.HINT] = "󰠠 ",
					[vim.diagnostic.severity.INFO] = " ",
				},
				texthl = {
					[vim.diagnostic.severity.ERROR] = "DiagnosticSignError",
					[vim.diagnostic.severity.WARN] = "DiagnosticSignWarn",
					[vim.diagnostic.severity.HINT] = "DiagnosticSignHint",
					[vim.diagnostic.severity.INFO] = "DiagnosticSignInfo",
				},
				numhl = {
					[vim.diagnostic.severity.ERROR] = "",
					[vim.diagnostic.severity.WARN] = "",
					[vim.diagnostic.severity.HINT] = "",
					[vim.diagnostic.severity.INFO] = "",
				},
			},
			virtual_text = true,
			update_in_insert = false,
			severity_sort = true,
		})

		-- Import cmp-nvim-lsp plugin
		local cmp_nvim_lsp = require("cmp_nvim_lsp")

		local keymap = vim.keymap

		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("UserLspConfig", {}),
			callback = function(ev)
				-- Buffer local mappings
				local opts = { buffer = ev.buf, silent = true }

				opts.desc = "See available code actions"
				keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)

				opts.desc = "Smart rename"
				keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)

				opts.desc = "Show line diagnostics"
				keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts)

				opts.desc = "Show documentation for what is under cursor"
				keymap.set("n", "K", vim.lsp.buf.hover, opts)

				opts.desc = "Restart LSP"
				keymap.set("n", "<leader>rs", ":LspRestart<CR>", opts)

				opts.desc = "Toggle inlay hints"
				keymap.set("n", "<leader>i", function()
					vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ 0 }), { 0 })
				end, opts)
			end,
		})

		-- Enable autocompletion capabilities
		local capabilities = cmp_nvim_lsp.default_capabilities()

		-- Configure LSP servers using native vim.lsp.config (Neovim 0.10+)

		-- Lua Language Server
		vim.lsp.config.lua_ls = {
			cmd = { "lua-language-server" },
			root_markers = { ".luarc.json", ".luarc.jsonc", ".luacheckrc", ".stylua.toml", "stylua.toml", "selene.toml", "selene.yml", ".git" },
			capabilities = capabilities,
			settings = {
				Lua = {
					diagnostics = {
						globals = { "vim", "Snacks" },
					},
					completion = {
						callSnippet = "Replace",
					},
					workspace = {
						checkThirdParty = false,
					},
					telemetry = {
						enable = false,
					},
				},
			},
		}

		-- TypeScript Language Server
		vim.lsp.config.ts_ls = {
			cmd = { "typescript-language-server", "--stdio" },
			root_markers = { "package.json", "tsconfig.json", "jsconfig.json", ".git" },
			capabilities = capabilities,
			init_options = {
				preferences = {
					disableSuggestions = true,
				},
			},
			on_attach = function(client, bufnr)
				vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
			end,
			settings = {
				javascript = {
					inlayHints = {
						includeInlayEnumMemberValueHints = true,
						includeInlayFunctionLikeReturnTypeHints = true,
						includeInlayFunctionParameterTypeHints = true,
						includeInlayParameterNameHints = "all",
						includeInlayParameterNameHintsWhenArgumentMatchesName = true,
						includeInlayPropertyDeclarationTypeHints = true,
						includeInlayVariableTypeHints = true,
					},
				},
				typescript = {
					inlayHints = {
						includeInlayEnumMemberValueHints = true,
						includeInlayFunctionLikeReturnTypeHints = true,
						includeInlayFunctionParameterTypeHints = true,
						includeInlayParameterNameHints = "all",
						includeInlayParameterNameHintsWhenArgumentMatchesName = true,
						includeInlayPropertyDeclarationTypeHints = true,
						includeInlayVariableTypeHints = true,
					},
				},
			},
		}

		-- Docker Language Server
		vim.lsp.config.dockerls = {
			cmd = { "docker-language-server", "--stdio" },
			root_markers = { "Dockerfile", ".git" },
			capabilities = capabilities,
		}

		-- SQL Language Server
		vim.lsp.config.sqls = {
			cmd = { "sqls" },
			root_markers = { ".git" },
			capabilities = capabilities,
		}

		-- Enable LSP servers for specific filetypes using native vim.lsp.enable()
		vim.api.nvim_create_autocmd("FileType", {
			pattern = "lua",
			callback = function(args)
				vim.lsp.enable("lua_ls")
			end,
		})

		vim.api.nvim_create_autocmd("FileType", {
			pattern = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
			callback = function(args)
				vim.lsp.enable("ts_ls")
			end,
		})

		vim.api.nvim_create_autocmd("FileType", {
			pattern = "dockerfile",
			callback = function(args)
				vim.lsp.enable("dockerls")
			end,
		})

		vim.api.nvim_create_autocmd("FileType", {
			pattern = "sql",
			callback = function(args)
				vim.lsp.enable("sqls")
			end,
		})
	end,
}
