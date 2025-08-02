local project_rooter_config = {
	patterns = { '.git', 'CMakeLists.txt', 'Makefile', 'package.json', 'Cargo.toml', 'pyproject.toml', 'go.mod', 'main.tex', '.root' },
	level_limit = 5, -- how many levels to go up
}

local function ProjectRooter()
	local config = project_rooter_config
	local patterns = config.patterns

	local current = vim.fn.expand('%:p:h')
	local level = 0

	local found = nil

	while found == nil and level <= config.level_limit do
		if vim.fn.isdirectory(current) == 1 then
			for _, pattern in ipairs(patterns) do
				if vim.fn.glob(current .. '/' .. pattern) ~= '' then
					-- Found a project root, set the working directory
					found = current
					break
				end
			end
		end

		if found ~= nil then
			break
		end

		current = vim.fn.fnamemodify(current, ':h')
		level = level + 1
	end

	if found == nil then
		-- No project root found, notify the user
		vim.notify('No project root found in ' .. vim.fn.expand('%:p:h'), vim.log.levels.WARN)
		return
	end

	vim.ui.input({
		prompt = 'Root found. Confirm: ',
		default = found,
		completion = 'dir',
	}, function(input)
			if input ~= nil and vim.fn.isdirectory(input) == 1 then
				vim.cmd.cd(input)
			end
		end)
end

return {
	setup = function()
		local wk = require 'which-key'

		wk.add({
			{ '<leader>pp', ProjectRooter, desc = 'Project rooter' },
		})
	end
}
