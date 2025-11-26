return {
	"rmagatti/auto-session",
	config = function()
		local auto_session = require("auto-session")

		auto_session.setup({
			auto_restore = true,
			session_lens = {
				picker = "snacks",
			},
		})

		local keymap = vim.keymap

		vim.o.sessionoptions = "blank,buffers,curdir,folds,help,options,tabpages,winsize,terminal,localoptions"

		keymap.set("n", "<leader>wr", "<cmd>AutoSession restore<CR>", { desc = "Restore session for cwd" })
		keymap.set("n", "<leader>ws", "<cmd>AutoSession save<CR>", { desc = "Save session for auto session root dir" })
		keymap.set("n", "<leader>wa", "<cmd>AutoSession search<CR>", { desc = "Search sessions" })
		keymap.set("n", "<leader>wd", "<cmd>AutoSession deletePicker<CR>", { desc = "Delete session" })
	end,
}
