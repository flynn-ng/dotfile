---@type vim.lsp.Config
return {
	cmd = { "tsgo", "lsp", "--stdio" },
	filetypes = {
		"javascript",
		"typescript",
	},
	root_markers = { "tsconfig.json", "jsconfig.json", "package.json", ".git" },
}
