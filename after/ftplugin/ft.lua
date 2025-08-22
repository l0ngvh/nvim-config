local helpers = require("hlong.helpers")

vim.lsp.enable({ "terraformls", "tflint" })
helpers.ensure_installed("terraform-ls")
helpers.ensure_installed("tflint")
