return {
	"nvim-tree/nvim-tree.lua",
	dependencies = "nvim-tree/nvim-web-devicons",
	config = function()
		local nvimtree = require("nvim-tree")

		vim.g.loaded_netrw = 1
		vim.g.loaded_netrwPlugin = 1

		vim.opt.termguicolors = true

		local HEIGHT_RATIO = 0.75
		local WIDTH_RATIO = 0.6

		nvimtree.setup({
			filters = {
				dotfiles = false,
				custom = { ".DS_Store" },
			},
			disable_netrw = true,
			hijack_cursor = true,
			sync_root_with_cwd = true,
			update_focused_file = {
				enable = true,
				update_root = false,
			},
			view = {
				float = {
					enable = true,
					quit_on_focus_loss = true,
					open_win_config = function()
						local screen_w = vim.opt.columns:get()
						local screen_h = vim.opt.lines:get() - vim.opt.cmdheight:get()
						local window_w = screen_w * WIDTH_RATIO
						local window_h = screen_h * HEIGHT_RATIO
						local window_w_int = math.floor(window_w)
						local window_h_int = math.floor(window_h)
						local center_x = (screen_w - window_w) / 2
						local center_y = (vim.opt.lines:get() - window_h) / 2 - vim.opt.cmdheight:get()
						-- local center_y = 2
						return {
							border = "rounded",
							relative = "editor",
							style = "minimal",
							row = center_y,
							col = center_x,
							width = window_w_int,
							height = window_h_int,
						}
					end,
				},
				width = function()
					return math.floor(vim.opt.columns:get() * WIDTH_RATIO)
				end,
			},
			renderer = {
				root_folder_label = false,
				highlight_git = "all",
				indent_markers = {
					enable = true,
				},
				full_name = true,
				icons = {
					glyphs = {
						default = "󰈚",
						folder = {
							default = "",
							empty = "",
							empty_open = "",
							open = "",
							symlink = "",
							arrow_closed = "󰐖",
							arrow_open = "",
						},
						git = { unmerged = "" },
					},
				},
			},
			actions = {
				open_file = {
					window_picker = {
						enable = true,
					},
				},
			},
			git = {
				ignore = false,
			},
		})

		vim.cmd("highlight NvimTreeNormal guibg=none")
		vim.cmd("highlight NvimTreeNormalFloat guibg=none")

		local keymap = vim.keymap

		keymap.set("n", "<leader>ee", "<cmd>NvimTreeToggle<CR>", { desc = "Toggle file explorer" })
		keymap.set(
			"n",
			"<leader>ef",
			"<cmd>NvimTreeFindFileToggle<CR>",
			{ desc = "Toggle file explorer on current file" }
		)
		keymap.set("n", "<leader>ec", "<cmd>NvimTreeCollapse<CR>", { desc = "Collapse file explorer" })
		keymap.set("n", "<leader>er", "<cmd>NvimTreeRefresh<CR>", { desc = "Refresh file explorer" })
	end,
}
