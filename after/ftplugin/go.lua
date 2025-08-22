local null_ls = require("null-ls")
local helpers = require("hlong.helpers")

helpers.ensure_installed("golangci-lint")

null_ls.register(null_ls.builtins.diagnostics.golangci_lint)
