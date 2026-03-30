return {
	"mfussenegger/nvim-jdtls",
	ft = "java",

	config = function()
		local jdtls = require("jdtls")

		-- ✅ Strict root detection for your Gradle + Eclipse project
		local root_dir = vim.fs.root(0, {
			"build.gradle",
			"build.gradle.kts",
			"pom.xml",
			".project",
		})

		-- ✅ Prevent JDTLS from attaching in wrong folders
		if not root_dir then
			return
		end

		local home = os.getenv("HOME")
		local project_name = vim.fn.fnamemodify(root_dir, ":t")
		local workspace_dir = home .. "/.local/share/nvim/jdtls-workspace/" .. project_name

		local config = {
			cmd = {
				vim.fn.stdpath("data") .. "/mason/bin/jdtls",
				"-data",
				workspace_dir,
			},

			root_dir = root_dir,

			-- ✅ Make completion + cmp work correctly
			capabilities = require("cmp_nvim_lsp").default_capabilities(),

			settings = {
				java = {
					signatureHelp = { enabled = true },
					contentProvider = { preferred = "fernflower" },

					format = {
						enabled = true,
					},

					configuration = {
						runtimes = {
							{
								name = "JavaSE-21",
								path = vim.fn.exepath("java"):gsub("/bin/java$", ""),
							},
						},
					},

					inlayHints = {
						parameterNames = {
							enabled = "all",
						},
					},
				},
			},

			-- ✅ Required by nvim-jdtls to avoid crashes on commands
			init_options = {
				bundles = {},
			},
		}

		-- ✅ This is REQUIRED for proper attach behavior
		jdtls.start_or_attach(config)
	end,
}
