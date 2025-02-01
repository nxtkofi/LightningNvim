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

function M.get_today_tasks()
	if not vim.g.setup.obsidian_dirs.generalpath then
		return { "Daily directory not specified" }
	end

	local generalpath = vim.fn.expand(vim.g.setup.obsidian_dirs.generalpath)
	local daily_path = generalpath .. "/daily 📝/"
	local today_file = os.date("%Y-%m-%d") .. ".md"
	local file_path = daily_path .. today_file

	if vim.fn.filereadable(file_path) == 0 then
		return { "Daily note not found: " .. today_file }
	end

	local content = vim.fn.readfile(file_path)
	local tasks = {}
	local in_todo = false

	for _, line in ipairs(content) do
		if line:lower():match("^#+%s*todo") then
			in_todo = true
		elseif in_todo and line:match("^#+") then
			break
		elseif in_todo and line:match("^%s*-%s*%[%s?x?%s?%]") then
			table.insert(tasks, line)
		end
	end

	return #tasks > 0 and tasks or { "No task in TODO section" }
end
function M.refresh_alpha_tasks()
	local alpha = require("alpha")
	local dashboard = require("alpha.themes.dashboard")
	dashboard.section.tasks.val = M.get_today_tasks()
	alpha.setup(dashboard.opts)
	vim.schedule(function()
		vim.cmd("AlphaRedraw")
	end)
end
function M.toggle_task(task_line)
	local date = os.date("%Y-%m-%d")
	local generalpath = vim.fn.expand(vim.g.setup.obsidian_dirs.generalpath)
	local daily_path = generalpath .. "/daily 📝/"
	local file_path = daily_path .. date .. ".md"

	if vim.fn.filereadable(file_path) == 0 then
		vim.notify("File doesn't exist: " .. file_path, vim.log.levels.ERROR)
		return
	end
	local lines = vim.fn.readfile(file_path)
	local modified = false
	local modified_line = nil
	local normalized_task = task_line:gsub("%[✓%]", "[x]"):gsub("^%s*", ""):gsub("%s*$", "")

	for i, line in ipairs(lines) do
		local normalized_line = line:gsub("^%s*", ""):gsub("%s*$", "")
		if normalized_line:match(vim.pesc(normalized_task:sub(6))) then
			if line:match("%[%s%]") then
				lines[i] = line:gsub("%[%s%]", "[x]")
			else
				lines[i] = line:gsub("%[x%]", "[ ]")
			end

			modified = true
			modified_line = lines[i]
			break
		end
	end

	if modified then
		vim.fn.writefile(lines, file_path)
		vim.cmd("checktime")
		M.refresh_alpha_tasks()

		if modified_line then
			vim.schedule(function()
				vim.notify("✓ Task updated: " .. modified_line, vim.log.levels.INFO)
			end)
		end
	else
		vim.notify("Couldn't find any task in file: " .. normalized_task, vim.log.levels.WARN)
	end
end
function M.show_interactive_tasks()
	local tasks = M.get_today_tasks()
	local reversed_tasks = vim.fn.reverse(vim.deepcopy(tasks))

	local pickers = require("telescope.pickers")
	local finders = require("telescope.finders")
	local conf = require("telescope.config").values
	local actions = require("telescope.actions")
	local action_state = require("telescope.actions.state")

	pickers
		.new({}, {
			prompt_title = "✅ Manage Your tasks - Enter: toggle, ESC: close window",
			finder = finders.new_table({
				results = reversed_tasks,
				entry_maker = function(entry)
					return {
						value = entry,
						display = entry:gsub("%[%s%]", "[ ]"):gsub("%[x%]", "[✓]"),
						ordinal = entry,
					}
				end,
			}),
			sorter = conf.generic_sorter({}),
			attach_mappings = function(prompt_bufnr)
				actions.select_default:replace(function()
					local selection = action_state.get_selected_entry()
					actions.close(prompt_bufnr)
					if selection then
						M.toggle_task(selection.value)
					end
				end)
				return true
			end,
		})
		:find()
end
return M
