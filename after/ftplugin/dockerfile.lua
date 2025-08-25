local lint = require("lint")
local treesitter = require("nvim-treesitter")
local helpers = require("hlong.helpers")

helpers.ensure_installed("hadolint")
treesitter.install({ "dockerfile" }):wait(300000)
vim.treesitter.start()
vim.wo[0][0].foldmethod = "expr"
vim.wo[0][0].foldexpr = "v:lua.vim.treesitter.foldexpr()"
lint.linters_by_ft.dockerfile = { "hadolint" }
