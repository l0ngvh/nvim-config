local conform = require("conform")
local treesitter = require("nvim-treesitter")
local helpers = require("hlong.helpers")

vim.lsp.config("lua_ls", {
	settings = {
		Lua = {
			runtime = {
				-- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
				version = "LuaJIT",
			},
			diagnostics = {
				-- Get the language server to recognize the `vim` global
				globals = { "vim" },
			},
			workspace = {
				-- Make the server aware of Neovim runtime files
				-- Filter by lua so that we get the lua directories instead of the parent directories
				-- Like ".config/nvim/lua" instead of ".config/nvim"
				-- This help strip out the lua prefix when using "require" to import modules
				library = vim.api.nvim_get_runtime_file("lua", true),
				checkThirdParty = "Disable",
			},
		},
	},
	on_attach = function(client, _)
		client.server_capabilities.documentFormattingProvider = false
	end,
})
vim.lsp.enable("lua_ls")
helpers.ensure_installed("lua-language-server")
helpers.ensure_installed("stylua")

conform.formatters_by_ft.lua = { "stylua" }
treesitter.install({ "lua" }):wait(300000)
vim.treesitter.start()
vim.wo[0][0].foldmethod = "expr"
vim.wo[0][0].foldexpr = "v:lua.vim.treesitter.foldexpr()"
