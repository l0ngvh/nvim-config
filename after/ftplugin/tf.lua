local treesitter = require("nvim-treesitter")
local helpers = require("hlong.helpers")

vim.lsp.enable({ "terraformls", "tflint" })
helpers.ensure_installed("terraform-ls")
helpers.ensure_installed("tflint")

vim.wo[0][0].foldmethod = "expr"
vim.wo[0][0].foldexpr = "v:lua.vim.treesitter.foldexpr()"
treesitter.install({ "hcl", "terraform" }):wait(300000)
vim.treesitter.start()
vim.wo[0][0].foldmethod = "expr"
vim.wo[0][0].foldexpr = "v:lua.vim.treesitter.foldexpr()"
