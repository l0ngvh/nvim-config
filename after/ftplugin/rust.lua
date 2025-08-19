local helpers = require("hlong.languages.helpers")

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
vim.lsp.enable("rust_analyzer", false)

helpers.ensure_installed("codelldb")
