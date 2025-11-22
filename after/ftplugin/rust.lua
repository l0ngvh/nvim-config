local conform = require("conform")
local treesitter = require("nvim-treesitter")
local helpers = require("hlong.helpers")

helpers.ensure_installed("rust-analyzer")

vim.wo[0][0].foldmethod = "expr"
vim.wo[0][0].foldexpr = "v:lua.vim.lsp.foldexpr()"

helpers.ensure_installed("codelldb")
conform.formatters_by_ft.rust = { "rustfmt" }
treesitter.install("rust"):wait(300000)
vim.treesitter.start()
