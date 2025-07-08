local function emit_osc7()
	local cwd = vim.fn.getcwd()
	-- OSC7 format: ESC + "]7;file://" + hostname + path + (ESC + \ or BEL)
	local hostname = vim.fn.hostname()
	local osc7 = string.format("\27]7;file://%s%s\27\\", hostname, cwd)
	vim.notify(vim.inspect(osc7))

	-- Write the sequence to stdout
	io.stdout:write(osc7)
end

-- Create an autocommand group
local osc7_group = vim.api.nvim_create_augroup("OSC7Directory", { clear = true })

-- Set up autocmds to trigger on directory change events
vim.api.nvim_create_autocmd({ "DirChanged" }, {
	group = osc7_group,
	callback = emit_osc7,
	desc = "Emit OSC7 sequence on directory change",
})

-- Also emit on startup
vim.api.nvim_create_autocmd({ "VimEnter" }, {
	group = osc7_group,
	callback = emit_osc7,
	desc = "Emit OSC7 sequence on Vim start",
})
