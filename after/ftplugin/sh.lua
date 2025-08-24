local null_ls = require("null-ls")
local treesitter = require("nvim-treesitter")
local helpers = require("hlong.helpers")

helpers.ensure_installed("shfmt")
helpers.ensure_installed("bash-language-server")

vim.lsp.enable("bashls")
null_ls.register(null_ls.builtins.formatting.shfmt)
treesitter.install("bash"):wait(300000)
vim.treesitter.start()
vim.wo[0][0].foldmethod = "expr"
vim.wo[0][0].foldexpr = "v:lua.vim.treesitter.foldexpr()"
