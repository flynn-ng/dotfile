vim.lsp.enable({ "tsgo", "gopls", "lua_ls", "rust_analyzer" })

vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("lsp_attach_keys", { clear = true }),
	callback = function(event)
		local map = function(keys, func, desc)
			vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
		end

		map("gd", vim.lsp.buf.definition, "Go to definition")
		map("gD", vim.lsp.buf.declaration, "Go to declaration")
		map("gt", vim.lsp.buf.type_definition, "Go to type definition")
		map("K", vim.lsp.buf.hover, "Hover")

		map("<leader>rn", vim.lsp.buf.rename, "Rename")
		map("<leader>ca", vim.lsp.buf.code_action, "Code action")
	end,
})
