local M = {}

function M.open_random_note()
	local vault_path = vim.g.setup.obsidian_dirs.mainnotes
	if not vault_path then
		vim.notify("Mainnotes directory not configured", vim.log.levels.ERROR)
		return
	end
	local expanded_path = vim.fn.expand(vault_path)
	local md_files = vim.split(vim.fn.globpath(expanded_path, "**/*.md"), "\n")
	md_files = vim.tbl_filter(function(file)
		return file ~= ""
	end, md_files)
	if #md_files == 0 then
		vim.notify("No markdown files found in: " .. expanded_path, vim.log.levels.WARN)
		return
	end
	math.randomseed(os.time())
	local random_file = md_files[math.random(#md_files)]
	vim.cmd("e " .. vim.fn.fnameescape(random_file))
end

return M
--[[ function OpenRandomNote() ]]
--[[ 			local mainnotes_dir = vim.g.setup.obsidian_dirs.mainnotes ]]
--[[ 			if not mainnotes_dir then ]]
--[[ 				print("Main notes directory is not set!") ]]
--[[ 				return ]]
--[[ 			end ]]
--[[]]
--[[ 			local handle = io.popen("find " .. mainnotes_dir .. " -type f -name '*.md' 2>/dev/null") ]]
--[[ 			if not handle then ]]
--[[ 				print("Failed to retrieve notes!") ]]
--[[ 				return ]]
--[[ 			end ]]
--[[]]
--[[ 			local files = {} ]]
--[[ 			for file in handle:lines() do ]]
--[[ 				table.insert(files, file) ]]
--[[ 			end ]]
--[[ 			handle:close() ]]
--[[]]
--[[ 			if #files == 0 then ]]
--[[ 				print("No markdown files found in " .. mainnotes_dir) ]]
--[[ 				return ]]
--[[ 			end ]]
--[[]]
--[[ 			local random_file = files[math.random(#files)] ]]
--[[ 			vim.cmd("edit " .. vim.fn.fnameescape(random_file)) ]]
--[[ 		end ]]
--[[]]
