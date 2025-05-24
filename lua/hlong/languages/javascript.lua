local mason_lsp_install = require("mason-lspconfig.install")
local mason_registry = require("mason-registry")
local null_ls = require("null-ls")
local null_ls_utils = require("null-ls.utils").make_conditional_utils()

--- @param package_name string
--- @return string
local function get_binary_path_in_node_modules(package_name)
	return "node_modules/.bin/" .. package_name
end

--- @param package_name string
--- @return boolean
local function is_installed_in_local_node_modules(package_name)
	return null_ls_utils.root_has_file(get_binary_path_in_node_modules(package_name))
end

local eslint = mason_registry.get_package("eslint-lsp")
if not eslint:is_installed() then
	mason_lsp_install.install(eslint)
end

local biome_cmd = nil
if is_installed_in_local_node_modules("biome") then
	biome_cmd = { get_binary_path_in_node_modules("biome"), "lsp-proxy" }
end

vim.lsp.config("biome", {
	cmd = biome_cmd,
})
vim.lsp.config("jsonls", {
	settings = {
		json = {
			schemas = require("schemastore").json.schemas(),
			validate = { enable = true },
		},
	},
	on_attach = function(client, _)
		client.server_capabilities.documentFormattingProvider = false
	end,
})
vim.lsp.config("ts_ls", {
	init_options = {
		preferences = { includeCompletionsForModuleExports = false },
	},
	on_attach = function(client, _)
		client.server_capabilities.documentFormattingProvider = false
	end,
})

vim.lsp.enable("eslint", is_installed_in_local_node_modules("eslint"))
vim.lsp.enable("biome", is_installed_in_local_node_modules("biome") or mason_registry.is_installed("biome"))
vim.lsp.enable("cssls")
vim.lsp.enable("jsonls")
vim.lsp.enable("ts_ls")
vim.lsp.enable("cucumber_language_server", mason_registry.is_installed("cucumber-language-server"))

if is_installed_in_local_node_modules("prettier") then
	null_ls.register({
		null_ls.builtins.formatting.prettier.with({
			command = get_binary_path_in_node_modules("prettier"),
			extra_filetypes = { "toml" },
		}),
	})
end
