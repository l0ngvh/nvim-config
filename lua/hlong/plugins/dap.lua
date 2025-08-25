return {
	{
		"mfussenegger/nvim-dap",
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			vim.fn.sign_define("DapBreakpoint", { text = "⏺", texthl = "Error", linehl = "", numhl = "" })
			vim.fn.sign_define("DapStopped", { text = "▶", texthl = "Added", linehl = "", numhl = "" })
		end,
	},
	{
		"rcarriga/nvim-dap-ui",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			"mfussenegger/nvim-dap",
			"nvim-neotest/nvim-nio",
		},
		config = function()
			local dap, dapui = require("dap"), require("dapui")
			dapui.setup({
				layouts = {
					{
						elements = {
							{
								id = "stacks",
								size = 0.33,
							},
							{
								id = "repl",
								size = 0.33,
							},
							{
								id = "console",
								size = 0.33,
							},
						},
						position = "left",
						size = 40,
					},
				},
			})
			dap.listeners.after.event_initialized["dapui_config"] = function()
				dapui.open()
			end
		end,
	},
	{
		"theHamsta/nvim-dap-virtual-text",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			"mfussenegger/nvim-dap",
		},
		opts = {},
	},
	{
		"suketa/nvim-dap-ruby",
		ft = { "ruby" },
		dependencies = {
			"mfussenegger/nvim-dap",
		},
		opts = {},
	},
}
