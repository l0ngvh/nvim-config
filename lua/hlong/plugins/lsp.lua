return {
	{
		"neovim/nvim-lspconfig",
		lazy = false, -- too many plugins depend on this, lazy loading it will cause issues
		dependencies = {
			"folke/neoconf.nvim",
		},
		config = function()
			require("neoconf").setup()

			require("lspconfig.ui.windows").default_options.border = "rounded"
		end,
	},
	{ "williamboman/mason.nvim", opts = {} },
	{ "b0o/schemastore.nvim" },
	{ "hrsh7th/cmp-nvim-lsp" },
	{
		"nvimtools/none-ls.nvim",
		event = { "BufReadPre", "BufNewFile" },
		main = "null-ls",
		opts = {
			border = "rounded",
			debounce = 1000,
			debug = false,
		},
	},
	{
		"williamboman/mason.nvim",
		cmd = "Mason",
		config = function()
			require("mason").setup({
				ui = {
					border = "rounded",
					icons = {
						package_installed = "",
						package_pending = "󰁇",
						package_uninstalled = "",
					},
				},
				log_level = vim.log.levels.INFO,
				max_concurrent_installers = 4,
			})
		end,
	},
	--- Enhance LuaLS
	{
		"folke/lazydev.nvim",
		ft = "lua", -- only load on lua files
		dependencies = {
			"Bilal2453/luvit-meta",
		},
		opts = {
			library = {
				-- See the configuration section for more details
				-- Load luvit types when the `vim.uv` word is found
				{ path = "luvit-meta/library", words = { "vim%.uv" } },
			},
		},
	},
	--- Displaying diagnostics, moving around LSP symbols
	{ "folke/trouble.nvim", cmd = { "Trouble" }, opts = {} },
}
