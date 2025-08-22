local null_ls = require("null-ls")

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
				library = {"C:\\Users\\mamlo\\AppData\\Local\\nvim\\lua"},
				checkThirdParty = "Disable",
			},
		},
	},
	on_attach = function(client, _)
		client.server_capabilities.documentFormattingProvider = false
	end,
})
vim.lsp.enable("lua_ls")

null_ls.register(null_ls.builtins.formatting.stylua)
