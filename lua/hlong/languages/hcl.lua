-- HCL is the language used in Terraform configuration files

vim.treesitter.language.register("terraform", "terraform-vars")
vim.lsp.enable({ "terraformls", "tflint" })
