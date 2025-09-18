return {
	"folke/snacks.nvim",
	priority = 1000,
	lazy = false,
	opts = {
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
		-- bufdelete
		{
			"<leader>ba",
			function()
				Snacks.bufdelete.all()
			end,
			desc = "Delete all buffer",
		},
		{
			"<leader>bn",
			function()
				Snacks.bufdelete.delete()
			end,
			desc = "Delete current buffer",
		},
		{
			"<leader>bc",
			function()
				Snacks.bufdelete.other()
			end,
			desc = "Delete all but current buffer",
		},
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
		{
			"<leader>.",
			function()
				Snacks.scratch()
			end,
			desc = "Toggle Scratch Buffer",
		},
		{
			"<leader>S",
			function()
				Snacks.scratch.select()
			end,
			desc = "Select Scratch Buffer",
		},
	},
}
