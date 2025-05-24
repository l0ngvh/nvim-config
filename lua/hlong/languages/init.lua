-- Set up language specific config
--
-- Can't put them in after/ftplugin due to how lspconfig works
-- Ref: https://github.com/neovim/nvim-lspconfig/issues/970#issuecomment-860133357

local cmp_nvim_lsp = require("cmp_nvim_lsp")
local keymaps = require("hlong.keymaps")

local lsp_group = vim.api.nvim_create_augroup("UserLspConfig", { clear = true })

vim.api.nvim_create_autocmd("LspAttach", {
  group = lsp_group,
  callback = function(args)
    local bufnr = args.buf
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if not client then
      return
    end

    keymaps.set(keymaps.lsp(bufnr))

    -- Enable auto-format on save
    if client.server_capabilities.documentFormattingProvider then
      vim.api.nvim_create_autocmd("BufWritePre", {
        buffer = bufnr,
        callback = function()
          vim.lsp.buf.format({ async = false, timeout = 2000 })
        end,
        group = lsp_group,
      })
    end

    if client.supports_method("textDocument/codeLens") then
      vim.api.nvim_create_autocmd({ "BufEnter", "CursorHold", "InsertLeave" }, {
        buffer = bufnr,
        callback = function()
          vim.lsp.codelens.refresh({ bufnr = bufnr })
        end,
        group = lsp_group,
      })
    end

    local inlay_hint_enable = false
    if client.server_capabilities.inlayHintProvider then
      inlay_hint_enable = true
    end

    vim.lsp.inlay_hint.enable(inlay_hint_enable)
  end,
})

local default_capabilities = vim.lsp.protocol.make_client_capabilities()
default_capabilities.textDocument.completion.completionItem.snippetSupport = true
default_capabilities = cmp_nvim_lsp.default_capabilities(default_capabilities)

vim.lsp.config("*", { capabilities = default_capabilities })

-- Include language specific configs
require("hlong.languages.docker")
require("hlong.languages.go")
require("hlong.languages.hcl")
require("hlong.languages.javascript")
require("hlong.languages.lua")
require("hlong.languages.python")
require("hlong.languages.ruby")
require("hlong.languages.rust")
require("hlong.languages.shell")
require("hlong.languages.yaml")
