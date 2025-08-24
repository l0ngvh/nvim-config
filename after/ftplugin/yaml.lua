require("nvim-treesitter").install("yaml"):wait(300000)
vim.treesitter.start()
vim.wo[0][0].foldmethod = "expr"
vim.wo[0][0].foldexpr = "v:lua.vim.treesitter.foldexpr()"

vim.lsp.config("yamlls", {
	settings = {
		yaml = {
			schemastore = { enable = true },
		},
	},
	on_attach = function(_, bufnr)
		if vim.bo[bufnr].buftype ~= "" or vim.bo[bufnr].filetype == "helm" then
			vim.diagnostic.enable(false, { bufnr })
		end
	end,
})

vim.lsp.enable("yamlls")
