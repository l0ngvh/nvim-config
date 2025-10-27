local conform = require("conform")
local treesitter = require("nvim-treesitter")
local helpers = require("hlong.helpers")

helpers.ensure_installed("shfmt")
helpers.ensure_installed("bash-language-server")

-- bashls doesn't fully support zsh
-- https://github.com/bash-lsp/bash-language-server/issues/252
vim.lsp.enable("bashls")
conform.formatters_by_ft.zsh = { "shfmt" }

-- There is a zsh grammar for zsh, but treesitter hasn't supported it yet
treesitter.install("bash"):wait(300000)
vim.treesitter.start(0, "bash")
vim.wo[0][0].foldmethod = "expr"
vim.wo[0][0].foldexpr = "v:lua.vim.treesitter.foldexpr()"
