local null_ls = require("null-ls")
local helpers = require("hlong.languages.helpers")

helpers.ensure_installed("golangci-lint")

null_ls.register(null_ls.builtins.diagnostics.golangci_lint)
