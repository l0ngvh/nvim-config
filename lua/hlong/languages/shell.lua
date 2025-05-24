local null_ls = require("null-ls")

vim.lsp.enable("bashls")
null_ls.register(null_ls.builtins.formatting.shfmt)
