local treesitter = require("nvim-treesitter")
local helpers = require("hlong.helpers")

treesitter.install({ "css" }):wait(300000)
vim.treesitter.start()

helpers.ensure_installed("css-lsp")
vim.lsp.enable("cssls")
vim.wo[0][0].foldmethod = "expr"
vim.wo[0][0].foldexpr = "v:lua.vim.treesitter.foldexpr()"
