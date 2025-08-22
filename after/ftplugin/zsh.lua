local null_ls = require("null-ls")
local helpers = require("hlong.helpers")

helpers.ensure_installed("shfmt")
helpers.ensure_installed("bash-language-server")

vim.lsp.enable("bashls")
null_ls.register(null_ls.builtins.formatting.shfmt)
