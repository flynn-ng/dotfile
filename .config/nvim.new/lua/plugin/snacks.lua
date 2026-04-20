vim.pack.add({
  "https://github.com/folke/snacks.nvim",
})

require("snacks").setup({
		bigfile = {
			enabled = true,
			notify = true,
			size = 1.5 * 1024 * 1024,
			line_length = 1000,
			-- Enable or disable features when big file detected
			---@param ctx {buf: number, ft:string}
			setup = function(ctx)
				if vim.fn.exists(":NoMatchParen") ~= 0 then
					vim.cmd([[NoMatchParen]])
				end
				Snacks.util.wo(0, { foldmethod = "manual", statuscolumn = "", conceallevel = 0 })
				vim.b.minianimate_disable = true
				vim.schedule(function()
					if vim.api.nvim_buf_is_valid(ctx.buf) then
						vim.bo[ctx.buf].syntax = ctx.ft
					end
				end)
			end,
		},
		bufdelete = {
			enabled = true,
		},
		dashboard = {
			enabled = true,
			sections = {
				{
					header = [[
     ___                       ___                         ___
    /\__\                     /\  \                       /\__\
   /:/  /          ___        \:\  \         ___         /:/ _/_
  /:/  /          /|  |        \:\  \       /\__\       /:/ /\__\
 /:/  /  ___     |:|  |    _____\:\  \     /:/  /      /:/ /:/ _/_
/:/__/  /\__\    |:|  |   /::::::::\__\   /:/__/      /:/_/:/ /\__\
\:\  \ /:/  /  __|:|__|   \:\~~\~~\/__/  /::\  \      \:\/:/ /:/  /
 \:\  /:/  /  /::::\  \    \:\  \       /:/\:\  \      \::/_/:/  /
  \:\/:/  /   ~~~~\:\  \    \:\  \      \/__\:\  \      \:\/:/  /
   \::/  /         \:\__\    \:\__\          \:\__\      \::/  /
    \/__/           \/__/     \/__/           \/__/       \/__/
          ]],
				},
			},
		},
		explorer = {
			enabled = true,
			replace_netrw = true,
			trash = false,
		},
		indent = {
			indent = {
				char = "┊",
				only_current = true,
				only_scope = true,
			},
		},
		input = {
			enabled = true,
		},
		lazygit = {
			enabled = true,
		},
		notifier = {
			enabled = true,
		},
		picker = {
			enabled = true,
			layout = { preset = "ivy" },
			sources = {
				explorer = {
					layout = { preset = "dropdown" },
					auto_close = true,
					follow_file = true,
					hidden = true,
					ignored = true,
				},
				lsp_references = {
					layout = { preset = "left" },
				},
			},
		},
		quickfile = {
			enabled = true,
		},
		scope = {
			enabled = true,
		},
		scratch = {
			enabled = true,
		},
		scroll = {
			enabled = false,
			animate = {
				duration = { step = 15, total = 100 },
			},
		},
		statuscolumn = {
			enabled = true,
		},
		toggle = {
			enabled = true,
		},
		words = {
			enabled = true,
		},
		profiler = {
			enabled = true,
		},
})

local map = vim.keymap.set

-- bufdelete
map("n", "<leader>ba", function() Snacks.bufdelete.all() end,   { desc = "Delete all buffer" })
map("n", "<leader>bn", function() Snacks.bufdelete.delete() end, { desc = "Delete current buffer" })
map("n", "<leader>bc", function() Snacks.bufdelete.other() end,  { desc = "Delete all but current buffer" })

-- lazygit
map("n", "<leader>lg", function() Snacks.lazygit() end,              { desc = "Lazygit" })
map("n", "<leader>lf", function() Snacks.lazygit.log_file() end,     { desc = "Lazygit Current File History" })
map("n", "<leader>ll", function() Snacks.lazygit.log() end,          { desc = "Lazygit Log (cwd)" })

-- notifier
map("n", "<leader>nn", function() Snacks.notifier.show_history() end, { desc = "Notification History" })
map("n", "<leader>nh", function() Snacks.notifier.hide() end,         { desc = "Dismiss All Notifications" })

-- rename
map("n", "<leader>rf", function() Snacks.rename.rename_file() end, { desc = "Rename File" })

-- words
map({ "n", "t" }, "]]", function() Snacks.words.jump(vim.v.count1) end,  { desc = "Next Reference" })
map({ "n", "t" }, "[[", function() Snacks.words.jump(-vim.v.count1) end, { desc = "Prev Reference" })

-- scratch
map("n", "<leader>.", function() Snacks.scratch() end,        { desc = "Toggle Scratch Buffer" })
map("n", "<leader>S", function() Snacks.scratch.select() end, { desc = "Select Scratch Buffer" })

-- picker
map("n", "<leader>fs", function() Snacks.picker.smart() end,                                  { desc = "Smart Find Files" })
map("n", "<leader>fb", function() Snacks.picker.buffers() end,                                { desc = "Buffers" })
map("n", "<leader>fw", function() Snacks.picker.grep() end,                                   { desc = "Grep" })
map("n", "<leader>fC", function() Snacks.picker.files({ cwd = vim.fn.stdpath("config") }) end, { desc = "Find Config File" })
map("n", "<leader>fc", function() Snacks.picker.command_history() end,                        { desc = "Command History" })
map("n", "<leader>fn", function() Snacks.picker.notifications() end,                          { desc = "Notification History" })
map("n", "<leader>ff", function() Snacks.picker.files() end,                                  { desc = "Find Files" })
map("n", "<leader>fg", function() Snacks.picker.git_files() end,                              { desc = "Find Git Files" })
map("n", "<leader>fp", function() Snacks.picker.projects() end,                               { desc = "Projects" })
map("n", "<leader>fr", function() Snacks.picker.recent() end,                                 { desc = "Recent" })

-- lsp via picker
map("n", "gd", function() Snacks.picker.lsp_definitions() end,                { desc = "Goto Definition" })
map("n", "gD", function() Snacks.picker.lsp_declarations() end,               { desc = "Goto Declaration" })
map("n", "gr", function() Snacks.picker.lsp_references() end,   { nowait = true, desc = "References" })
map("n", "gI", function() Snacks.picker.lsp_implementations() end,            { desc = "Goto Implementation" })
map("n", "gy", function() Snacks.picker.lsp_type_definitions() end,           { desc = "Goto Type Definition" })
map("n", "gai", function() Snacks.picker.lsp_incoming_calls() end,            { desc = "Calls Incoming" })
map("n", "gao", function() Snacks.picker.lsp_outgoing_calls() end,            { desc = "Calls Outgoing" })
map("n", "<leader>ss", function() Snacks.picker.lsp_symbols() end,            { desc = "LSP Symbols" })
map("n", "<leader>sS", function() Snacks.picker.lsp_workspace_symbols() end,  { desc = "LSP Workspace Symbols" })

-- profiler
map("n", "<leader>ps", function() Snacks.profiler.scratch() end, { desc = "Profiler Scratch Buffer" })

-- explorer
map("n", "<leader>e", function() Snacks.explorer() end, { desc = "Explorer" })
