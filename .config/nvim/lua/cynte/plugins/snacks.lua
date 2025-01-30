return {
	"folke/snacks.nvim",
	priority = 1000,
	lazy = false,
	opts = {
		bigfile = {
			enabled = true,
		},
		dashboard = {
			enabled = true,
			sections = {
				{
					section = "terminal",
					cmd = "toilet -F gay Cynte; sleep .1",
					hl = "header",
					padding = 1,
					indent = 12,
				},
				{
					section = "startup",
				},
				function()
					local in_git = Snacks.git.get_root() ~= nil
					local cmds = {
						{
							icon = " ",
							title = "Git Status",
							cmd = "git --no-pager diff --stat -B -M -C",
							height = 10,
						},
					}
					return vim.tbl_map(function(cmd)
						return vim.tbl_extend("force", {
							pane = 2,
							section = "terminal",
							enabled = in_git,
							padding = 1,
							ttl = 5 * 60,
							indent = 3,
						}, cmd)
					end, cmds)
				end,
			},
		},
		indent = {
			indent = {
				char = "┊",
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
		-- scroll = {
		-- 	enabled = true,
		-- 	animate = {
		-- 		duration = { step = 15, total = 100 },
		-- 	},
		-- },
		statuscolumn = {
			enabled = true,
		},
		toggle = {
			enabled = true,
		},
		words = {
			enabled = true,
		},
	},
	keys = {
		{
			"<leader>lg",
			function()
				Snacks.lazygit()
			end,
			desc = "Lazygit",
		},
		{
			"<leader>lf",
			function()
				Snacks.lazygit.log_file()
			end,
			desc = "Lazygit Current File History",
		},
		{
			"<leader>ll",
			function()
				Snacks.lazygit.log()
			end,
			desc = "Lazygit Log (cwd)",
		},
		{
			"<leader>hb",
			function()
				Snacks.git.blame_line()
			end,
			desc = "Git Blame line",
		},
		{
			"<leader>hB",
			function()
				Snacks.gitbrowse()
			end,
			desc = "Git Browse",
			mode = { "n", "v" },
		},
		{
			"<leader>nn",
			function()
				Snacks.notifier.show_history()
			end,
			desc = "Notification History",
		},
		{
			"<leader>nh",
			function()
				Snacks.notifier.hide()
			end,
			desc = "Dismiss All Notifications",
		},
		{
			"<leader>rf",
			function()
				Snacks.rename.rename_file()
			end,
			desc = "Rename File",
		},
		{
			"]]",
			function()
				Snacks.words.jump(vim.v.count1)
			end,
			desc = "Next Reference",
			mode = { "n", "t" },
		},
		{
			"[[",
			function()
				Snacks.words.jump(-vim.v.count1)
			end,
			desc = "Prev Reference",
			mode = { "n", "t" },
		},
	},
}
