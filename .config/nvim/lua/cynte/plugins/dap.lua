return {
	{
		"mfussenegger/nvim-dap",
		dependencies = {
			"rcarriga/nvim-dap-ui",
			"jay-babu/mason-nvim-dap.nvim",
			"williamboman/mason.nvim",
			"nvim-telescope/telescope-dap.nvim",
			"nvim-neotest/nvim-nio",
			{
				"theHamsta/nvim-dap-virtual-text",
				opts = {},
			},
		},
		keys = {
			{
				"<leader>dB",
				function()
					require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: "))
				end,
				desc = "Breakpoint Condition",
			},
			{
				"<leader>db",
				function()
					require("dap").toggle_breakpoint()
				end,
				desc = "Toggle Breakpoint",
			},
			{
				"<leader>dc",
				function()
					require("dap").continue()
				end,
				desc = "Run/Continue",
			},
			{
				"<leader>da",
				function()
					require("dap").continue({ before = get_args })
				end,
				desc = "Run with Args",
			},
			{
				"<leader>dC",
				function()
					require("dap").run_to_cursor()
				end,
				desc = "Run to Cursor",
			},
			{
				"<leader>dg",
				function()
					require("dap").goto_()
				end,
				desc = "Go to Line (No Execute)",
			},
			{
				"<leader>di",
				function()
					require("dap").step_into()
				end,
				desc = "Step Into",
			},
			{
				"<leader>dn",
				function()
					require("dap").down()
				end,
				desc = "Down",
			},
			{
				"<leader>dp",
				function()
					require("dap").up()
				end,
				desc = "Up",
			},
			{
				"<leader>dl",
				function()
					require("dap").run_last()
				end,
				desc = "Run Last",
			},
			{
				"<leader>do",
				function()
					require("dap").step_out()
				end,
				desc = "Step Out",
			},
			{
				"<leader>dk",
				function()
					require("dap").step_over()
				end,
				desc = "Step Over",
			},
			{
				"<leader>dP",
				function()
					require("dap").pause()
				end,
				desc = "Pause",
			},
			{
				"<leader>dr",
				function()
					require("dap").repl.toggle()
				end,
				desc = "Toggle REPL",
			},
			{
				"<leader>ds",
				function()
					require("dap").session()
				end,
				desc = "Session",
			},
			{
				"<leader>dt",
				function()
					require("dap").terminate()
				end,
				desc = "Terminate",
			},
			{
				"<leader>dw",
				function()
					require("dap.ui.widgets").hover()
				end,
				desc = "Widgets",
			},
			{
				"<leader>du",
				function()
					require("dapui").toggle({})
				end,
				desc = "Dap UI",
			},
			{
				"<leader>de",
				function()
					require("dap").eval()
				end,
				desc = "Eval",
				mode = { "n", "v" },
			},
		},
		config = function()
			local dap = require("dap")
			local dapui = require("dapui")

			local js_debug_path = require("mason.settings").current.install_root_dir .. "/packages/js-debug-adapter"

			dap.adapters["pwa-node"] = {
				type = "server",
				host = "localhost",
				port = "${port}",
				executable = {
					command = "node",
					args = { js_debug_path .. "/js-debug/src/dapDebugServer.js", "${port}" },
				},
			}
			dap.configurations.typescript = {
				{
					type = "pwa-node",
					request = "launch",
					name = "Launch - Command",
					outputCapture = "std",
					cwd = vim.fn.getcwd(),
					runtimeExecutable = function()
						input = vim.fn.input("Enter debug command: ")
						local parts = vim.split(input, " ")
						return parts[1]
					end,
					runtimeArgs = function()
						local parts = vim.split(input, " ")
						return vim.list_slice(parts, 2)
					end,
				},
				{
					type = "pwa-node",
					request = "launch",
					name = "Launch - yarn start:debug",
					cwd = vim.fn.getcwd(),
					runtimeExecutable = "yarn",
					runtimeArgs = { "start:debug" },
					console = "integratedTerminal",
				},
				{
					type = "pwa-node",
					request = "attach",
					name = "Attach",
					cwd = vim.fn.getcwd(),
					sourceMaps = true,
					outputCapture = "std",
				},
				{
					type = "pwa-node",
					request = "attach",
					name = "Attach - Pick Process",
					processId = require("dap.utils").pick_process,
					cwd = vim.fn.getcwd(),
					sourceMaps = true,
				},
			}

			-- dap.configurations.typescript = {
			-- 	{
			-- 		name = "Launch NestJS",
			-- 		type = "pwa-node",
			-- 		request = "launch",
			-- 		program = "${workspaceFolder}/node_modules/@nestjs/cli/bin/nest.js",
			-- 		args = { "start", "--debug", "--watch" },
			-- 		cwd = "${workspaceFolder}",
			-- 		runtimeExecutable = "node",
			-- 		sourceMaps = true,
			-- 		protocol = "inspector",
			-- 		console = "integratedTerminal",
			-- 		outFiles = { "${workspaceFolder}/dist/**/*.js" },
			-- 		skipFiles = { "<node_internals>/**", "node_modules/**" },
			-- 	},
			-- }

			dapui.setup()

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
-- local dap = require("dap")
--
-- local input = ""
--
-- dap.adapters["pwa-node"] = {
--     type = "server",
--     host = "localhost",
--     port = "${port}",
--     executable = {
--         command = "js-debug-adapter",
--         args = { "${port}" },
--     },
-- }
--
-- local configurations = {
--     {
--         type = "pwa-node",
--         request = "launch",
--         name = "Launch - Command",
--         outputCapture = "std",
--         cwd = vim.fn.getcwd(),
--         runtimeExecutable = (function()
--             input = vim.fn.input("Enter debug command: ")
--             local parts = vim.split(input, " ")
--             return parts[1]
--         end),
--         runtimeArgs = (function()
--             local parts = vim.split(input, " ")
--             return vim.list_slice(parts, 2)
--         end),
--     },
--     {
--         type = "pwa-node",
--         request = "launch",
--         name = "Launch - yarn start:debug",
--         cwd = vim.fn.getcwd(),
--         runtimeExecutable = "yarn",
--         runtimeArgs = { "start:debug" },
--         console = 'integratedTerminal'
--     },
--     {
--         type = "pwa-node",
--         request = "attach",
--         name = "Attach",
--         cwd = vim.fn.getcwd(),
--         sourceMaps = true,
--         outputCapture = "std",
--     },
--     {
--         type = "pwa-node",
--         request = "attach",
--         name = "Attach - Pick Process",
--         processId = require("dap.utils").pick_process,
--         cwd = vim.fn.getcwd(),
--         sourceMaps = true,
--     },
-- }
--
-- dap.configurations.typescript = configurations
-- dap.configurations.javascript = configurations
-- dap.configurations.typescriptreact = configurations
-- dap.configurations.javascriptreact = configurations
--
