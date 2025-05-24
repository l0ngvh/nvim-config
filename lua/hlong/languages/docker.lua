local null_ls = require("null-ls")

vim.filetype.add({
	filename = {
		["devcontainer.json"] = "jsonc",
	},
})

null_ls.register(null_ls.builtins.diagnostics.hadolint)
