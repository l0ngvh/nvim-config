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

null_ls.register(null_ls.builtins.formatting.stylua)
