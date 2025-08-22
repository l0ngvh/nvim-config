vim.lsp.config("yamlls", {
	settings = {
		yaml = {
			schemastore = { enable = true },
		},
	},
	on_attach = function(_, bufnr)
		if vim.bo[bufnr].buftype ~= "" or vim.bo[bufnr].filetype == "helm" then
			vim.diagnostic.disable(bufnr)
			vim.diagnostic.enable(false, { bufnr })
		end
	end,
})

vim.lsp.enable("yamlls")
