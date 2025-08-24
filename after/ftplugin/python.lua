local conform = require("conform")
local treesitter = require("nvim-treesitter")

vim.lsp.config("pyright", {
	settings = {
		python = {
			analysis = {
				typeCheckingMode = "basic",
			},
		},
	},
})
vim.lsp.config("ruff", {
	on_attach = function(client, _)
		client.server_capabilities.hoverProvider = false
	end,
})

vim.lsp.enable("pyright")
vim.lsp.enable("ruff")

conform.formatters_by_ft.python = { "ruff_format" }
treesitter.install("python"):wait(300000)
vim.treesitter.start()
vim.wo[0][0].foldmethod = "expr"
vim.wo[0][0].foldexpr = "v:lua.vim.treesitter.foldexpr()"
