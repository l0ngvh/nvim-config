-- Set up language specific config

local cmp_nvim_lsp = require("cmp_nvim_lsp")
local conform = require("conform")
local keymaps = require("hlong.keymaps")

local language_group = vim.api.nvim_create_augroup("UserLanguageConfig", { clear = true })

vim.api.nvim_create_autocmd("LspAttach", {
	group = language_group,
	callback = function(args)
		local bufnr = args.buf
		local client = vim.lsp.get_client_by_id(args.data.client_id)
		if not client then
			return
		end

		keymaps.set(keymaps.lsp(bufnr))

		if client.supports_method("textDocument/codeLens") then
			vim.api.nvim_create_autocmd({ "BufEnter", "CursorHold", "InsertLeave" }, {
				buffer = bufnr,
				callback = function()
					vim.lsp.codelens.refresh({ bufnr = bufnr })
				end,
				group = language_group,
			})
		end

		local inlay_hint_enable = false
		if client.server_capabilities.inlayHintProvider then
			inlay_hint_enable = true
		end

		vim.lsp.inlay_hint.enable(inlay_hint_enable)
	end,
})

vim.api.nvim_create_autocmd("BufWritePre", {
	callback = function()
		if vim.g.disable_autoformat or vim.b.disable_autoformat then
			return
		end
		conform.format({ timeout_ms = 1000 })
	end,
	group = language_group,
})

-- https://github.com/stevearc/conform.nvim/blob/master/doc/recipes.md#command-to-toggle-format-on-save
vim.api.nvim_create_user_command("FormatDisable", function(args)
	if args.bang then
		vim.g.disable_autoformat = true
	else
		-- FormatDisable will disable formatting just for this buffer
		vim.b.disable_autoformat = true
	end
end, {
	desc = "Disable autoformat-on-save",
	bang = true,
})
vim.api.nvim_create_user_command("FormatEnable", function()
	vim.b.disable_autoformat = false
	vim.g.disable_autoformat = false
end, {
	desc = "Re-enable autoformat-on-save",
})

local default_capabilities = vim.lsp.protocol.make_client_capabilities()
default_capabilities.textDocument.completion.completionItem.snippetSupport = true
default_capabilities = cmp_nvim_lsp.default_capabilities(default_capabilities)

vim.lsp.config("*", { capabilities = default_capabilities })

vim.lsp.enable("harper_ls")

vim.filetype.add({
	filename = {
		["devcontainer.json"] = "jsonc",
	},
})

vim.treesitter.language.register("terraform", "terraform-vars")
