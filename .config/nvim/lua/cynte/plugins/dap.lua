return {
	{
		"mfussenegger/nvim-dap",
		dependencies = {
			"rcarriga/nvim-dap-ui",
			"jay-babu/mason-nvim-dap.nvim",
			"williamboman/mason.nvim",
			"nvim-telescope/telescope-dap.nvim",
			"nvim-neotest/nvim-nio", -- ✅ Required for nvim-dap-ui
		},
		config = function()
			local dap = require("dap")
			local dapui = require("dapui")

			require("mason").setup()
			require("mason-nvim-dap").setup({
				ensure_installed = { "node-debug2-adapter" },
			})

			dap.adapters.node2 = {
				type = "executable",
				command = "node",
				args = { vim.fn.stdpath("data") .. "/mason/packages/node-debug2-adapter/out/src/nodeDebug.js" },
			}

			dap.configurations.typescript = {
				{
					name = "Launch NestJS",
					type = "node2",
					request = "launch",
					program = "${workspaceFolder}/node_modules/.bin/nest",
					args = { "start", "--debug", "--watch" },
					cwd = "${workspaceFolder}",
					runtimeExecutable = "node",
					sourceMaps = true,
					protocol = "inspector",
					console = "integratedTerminal",
					outFiles = { "${workspaceFolder}/dist/**/*.js" },
				},
			}

			dapui.setup()

			vim.keymap.set("n", "<F5>", function()
				dap.continue()
			end, { desc = "Start/Continue Debugging" })
			vim.keymap.set("n", "<F9>", function()
				dap.toggle_breakpoint()
			end, { desc = "Toggle Breakpoint" })
			vim.keymap.set("n", "<F10>", function()
				dap.step_over()
			end, { desc = "Step Over" })
			vim.keymap.set("n", "<F11>", function()
				dap.step_into()
			end, { desc = "Step Into" })
			vim.keymap.set("n", "<F12>", function()
				dap.step_out()
			end, { desc = "Step Out" })
			vim.keymap.set("n", "<leader>dr", function()
				dap.repl.open()
			end, { desc = "Open Debug REPL" })
			vim.keymap.set("n", "<leader>du", function()
				dapui.toggle()
			end, { desc = "Toggle Debug UI" })

			-- Automatically open/close dap-ui
			dap.listeners.after.event_initialized["dapui_config"] = function()
				dapui.open()
			end
			dap.listeners.before.event_terminated["dapui_config"] = function()
				dapui.close()
			end
			dap.listeners.before.event_exited["dapui_config"] = function()
				dapui.close()
			end
		end,
	},
}
