local mason_registry = require("mason-registry")

--- @class Helpers
--- @field ensure_installed fun(package_name: string)
local M = {}

--- Install a package through mason if that package is not already installed on the current system
--- @param package_name string
function M.ensure_installed(package_name)
	local package = mason_registry.get_package(package_name)
	if not package:is_installed() then
		package:install()
	end
end

--- Check if a package is installed, either locally inside a project (e.g. through packages.json), or from mason
--- @param package_name string
function M.is_installed(package_name)
	local package = mason_registry.get_package(package_name)
	if not package:is_installed() then
		package:install()
	end
end

return M
