local conform = require("conform")
local helpers = require("hlong.helpers")

vim.lsp.enable("rust_analyzer", false)

vim.g.rustaceanvim = {
	server = {
		default_settings = {
			["rust-analyzer"] = {
				inlayHints = {
					typeHints = {
						enable = false,
					},
				},
			},
		},
	},
	tools = {
		hover_actions = {
			replace_builtin_hover = false,
		},
		float_win_config = {
			border = "rounded",
		},
	},
}

helpers.ensure_installed("rust-analyzer")

-- rustaceanvim already launches its own rust-analyzer server

helpers.ensure_installed("codelldb")
conform.formatters_by_ft.rust = { "rustfmt" }
