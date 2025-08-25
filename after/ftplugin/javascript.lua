local mason_registry = require("mason-registry")
local conform = require("conform")
local treesitter = require("nvim-treesitter")
local helpers = require("hlong.helpers")

-- Check if a file exists in the root directory
local function root_has_file(filename)
	local path = vim.fn.getcwd() .. "/" .. filename
	local stat = vim.loop.fs_stat(path)
	return stat ~= nil
end

--- @param package_name string
--- @return string
local function get_local_bin(package_name)
	return "node_modules/.bin/" .. package_name
end

--- @param package_name string
--- @return boolean
local function is_local(package_name)
	return root_has_file(get_local_bin(package_name))
end

helpers.ensure_installed("eslint-lsp")
-- helpers.ensure_installed("prettier")
helpers.ensure_installed("css-lsp")

if is_local("biome") then
	local biome_cmd = { get_local_bin("biome"), "lsp-proxy" }
	vim.lsp.config("biome", {
		cmd = biome_cmd,
	})
end

vim.lsp.config("ts_ls", {
	init_options = {
		preferences = { includeCompletionsForModuleExports = false },
	},
	on_attach = function(client, _)
		client.server_capabilities.documentFormattingProvider = false
	end,
})

vim.lsp.enable("eslint", is_local("eslint"))
vim.lsp.enable("biome", is_local("biome") or mason_registry.is_installed("biome"))
vim.lsp.enable("cssls")
vim.lsp.enable("ts_ls")
vim.lsp.enable("cucumber_language_server", mason_registry.is_installed("cucumber-language-server"))

if is_local("prettier") then
	conform.formatters.prettier = {
		command = get_local_bin("prettier"),
	}
end

conform.formatters_by_ft.javascript = { "prettier" }
treesitter
	.install({
		"css",
		"javascript",
		"tsx",
		"typescript",
	})
	:wait(300000)
vim.treesitter.start()
vim.wo[0][0].foldmethod = "expr"
vim.wo[0][0].foldexpr = "v:lua.vim.treesitter.foldexpr()"
