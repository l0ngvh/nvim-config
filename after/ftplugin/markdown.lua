local treesitter = require("nvim-treesitter")

treesitter.install({ "markdown", "markdown_inline" }):wait(300000)
vim.treesitter.start()
vim.wo[0][0].foldmethod = "expr"
vim.wo[0][0].foldexpr = "v:lua.vim.treesitter.foldexpr()"
