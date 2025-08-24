local null_ls = require("null-ls")
local treesitter = require("nvim-treesitter")
local helpers = require("hlong.helpers")

helpers.ensure_installed("hadolint")
null_ls.register(null_ls.builtins.diagnostics.hadolint)
treesitter.install({ "dockerfile" }):wait(300000)
vim.treesitter.start()
vim.wo[0][0].foldmethod = "expr"
vim.wo[0][0].foldexpr = "v:lua.vim.treesitter.foldexpr()"
