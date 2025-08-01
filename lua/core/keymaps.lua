local map = function(mode, keys, func, desc, opts)
	opts = opts or {}
	opts.desc = desc
	vim.keymap.set(mode, keys, func, opts)
end

local setup = require("setup")
local builtin = require("telescope.builtin")
local dap = require("dap")

-- Set keymaps to control the debugger
map("n", "<F5>", dap.continue)

map("n", "<F9>", dap.step_back)
map("n", "<F10>", dap.step_into)
map("n", "<F11>", dap.step_over)
map("n", "<F12>", dap.step_out)
map("n", "<leader>tb", dap.toggle_breakpoint)
map("n", "<leader>B", function()
	require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: "))
end)
-- LSP and Diagnostics
map("n", "<C-.>", vim.lsp.buf.code_action, "Code Action")
map("n", "[d", function()
	vim.diagnostic.jump({ count = -1, float = true })
end, "Go to prev [D]iagnostic message")
map("n", "]d", function()
	vim.diagnostic.jump({ count = 1, float = true })
end, "Go to next [D]iagnostic message")
map("n", "<leader>q", vim.diagnostic.setloclist, "Open diagnostic [Q]uickfix list")

map("n", "gK", function()
	local new_config = not vim.diagnostic.config().virtual_lines
	vim.diagnostic.config({ virtual_lines = new_config })
end)

-- Terminal
map("n", "<leader>1", function()
	require("toggleterm").toggle(1)
end, "erminal 1")

map("n", "<leader>2", function()
	require("toggleterm").toggle(2)
end, "Toggle terminal 2")

-- Exit search highlight
map("n", "<Esc>", "<cmd>nohlsearch<CR>", "Clear search highlight")
map("t", "<Esc><Esc>", "<C-\\><C-n>", "Exit terminal mode")
-- Window navigation
-- This depends on Your preferences, I was always using <C-w><C-direction> and have never had any problems with it, therefore I don't need those mappings
--[[ map("n", "<C-h>", "<C-w><C-h>", "Move focus to the left window") ]]
--[[ map("n", "<C-l>", "<C-w><C-l>", "Move focus to the right window") ]]
--[[ map("n", "<C-j>", "<C-w><C-j>", "Move focus to the lower window") ]]
--[[ map("n", "<C-k>", "<C-w><C-k>", "Move focus to the upper window") ]]

-- Arrow keys hint
map("n", "<left>", '<cmd>echo "Use h to move!!"<CR>', "Hint: Use h")
map("n", "<right>", '<cmd>echo "Use l to move!!"<CR>', "Hint: Use l")
map("n", "<up>", '<cmd>echo "Use k to move!!"<CR>', "Hint: Use k")
map("n", "<down>", '<cmd>echo "Use j to move!!"<CR>', "Hint: Use j")

-- Open URL in Firefox
map("n", "<C-CR>", function()
	-- Pobierz linię, w której znajduje się kursor
	local line = vim.fn.getline(".")
	-- Pobierz pozycję kursora w tej linii
	local cursor_col = vim.fn.col(".")

	-- Funkcja do sprawdzania, czy kursor znajduje się w zakresie
	local function is_cursor_within_range(start_pos, end_pos)
		return cursor_col >= start_pos and cursor_col <= end_pos
	end

	-- Wyszukaj Markdown-style linki `[tekst](url)`
	for label, url in line:gmatch("%[(.-)%]%((.-)%)") do
		local start_pos, end_pos = line:find("%[" .. label .. "%]%(" .. url .. "%)")
		if start_pos and end_pos and is_cursor_within_range(start_pos, end_pos) then
			vim.fn.jobstart({ "zen-browser", url }, { detach = true })
			return
		end
	end

	-- Wyszukaj URL w nawiasach `()`
	for url in line:gmatch("%b()") do
		local clean_url = url:sub(2, -2) -- Usuń nawiasy
		if clean_url:match("^https?://") or clean_url:match("^http://") then
			vim.fn.jobstart({ "zen-browser", clean_url }, { detach = true })
			return
		end
	end

	-- Wyszukaj surowy URL bez Markdown-style linków
	for url in line:gmatch("https?://[%w._~:/?#@!$&'()*+,;=-]+") do
		local start_pos, end_pos = line:find(url, 1, true)
		if start_pos and end_pos and is_cursor_within_range(start_pos, end_pos) then
			vim.fn.jobstart({ "zen-browser", url }, { detach = true })
			return
		end
	end

	print("No valid URL detected.")
end, "Open URL in Firefox")

-- Telescope commands
map("n", "<leader>sp", ":Telescope repo list<CR>", "[S]earch Git [P]rojects", { noremap = true, silent = true })
map("n", "<leader>sh", builtin.help_tags, "[S]earch [H]elp")
map("n", "<leader>sk", builtin.keymaps, "[S]earch [K]eymaps")
map("n", "<leader>p", builtin.find_files, "[S]earch [F]iles")
map("n", "<leader>ss", builtin.builtin, "[S]earch [S]elect Telescope")
map("n", "<leader>sw", builtin.grep_string, "[S]earch current [W]ord")
map("n", "<leader>sg", builtin.live_grep, "[S]earch by [G]rep")
map("n", "<leader>sd", builtin.diagnostics, "[S]earch [D]iagnostics")
map("n", "<leader>sr", builtin.resume, "[S]earch [R]esume")
map("n", "<leader>s.", builtin.oldfiles, '[S]earch Recent Files ("." for repeat)')
map("n", "<leader><leader>", builtin.buffers, "[ ] Find existing buffers")
map("n", "gd", builtin.lsp_definitions, "[G]oto [D]efinition")
map("n", "gr", builtin.lsp_references, "[G]oto [R]eferences")
map("n", "gI", builtin.lsp_implementations, "[G]oto [I]mplementation")
map("n", "<leader>D", builtin.lsp_type_definitions, "Type [D]efinition")
map("n", "<leader>ds", builtin.lsp_document_symbols, "[D]ocument [S]ymbols")
map("n", "<leader>ws", builtin.lsp_dynamic_workspace_symbols, "[W]orkspace [S]ymbols")
map("n", "<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
map("n", "gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
local zettelkasten_directory = vim.fn.expand(setup.obsidian_dirs.generalpath)
vim.keymap.set("n", "<leader>zt", function()
	builtin.live_grep({ cwd = zettelkasten_directory })
end, { desc = "Search [Z]ettelkasten [T]ext." })
vim.keymap.set("n", "<leader>zf", function()
	builtin.find_files({ cwd = zettelkasten_directory })
end, { desc = "Search [Z]ettelkasten [F]iles." })

-- TODO: exclude /daily from search
--
vim.keymap.set("n", "<leader>sl", function()
	local word = vim.fn.input("Search in current line: ")
	local line_number = vim.fn.line(".")
	vim.cmd("/\\%" .. line_number .. "l" .. word)
end, { desc = "[S]earch [L]ine for word " })

-- Advanced Telescope examples
map("n", "<leader>/", function()
	builtin.current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
		winblend = 4,
		previewer = false,
	}))
end, "[/] Fuzzily search in current buffer")

map("n", "<leader>s/", function()
	builtin.live_grep({
		grep_open_files = true,
		prompt_title = "Live Grep in Open Files",
	})
end, "[S]earch [/] in Open Files")

map("n", "<leader>sn", function()
	builtin.find_files({ cwd = vim.fn.stdpath("config") })
end, "[S]earch [N]eovim files")

-- UndoTree and file explorer
map("n", "<leader>u", ":UndotreeToggle<CR>", "Toggle UndoTree")
map("n", "<leader>b", ":lua Snacks.explorer()<CR>", "Toggle file explorer", { noremap = true, silent = true })

-- Diffview
map("n", "<leader>dvo", ":DiffviewOpen<CR>", "DiffView Open")
map("n", "<leader>dvc", ":DiffviewClose<CR>", "DiffView Close")

-- Translate
map("n", "<leader>tp", ":Translate pl<CR>", "Translate to Polish")
map("v", "<leader>tp", ":Translate pl<CR>", "Translate to Polish (Visual)")
map("n", "<leader>te", ":Translate en<CR>", "Translate to English")
map("v", "<leader>te", ":Translate en<CR>", "Translate to English (Visual)")
-- Diagnostics toggle
map("n", "<leader>ts", toggle_autosave, "Toggle Autosave")
map("n", "<leader>th", function()
	vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf }))
end, "[T]oggle Inlay [H]ints")
-- Quickfix navigation
map("n", "<M-j>", ":cnext<CR>", "Next Quickfix")
map("n", "<M-k>", ":cprev<CR>", "Previous Quickfix")

-- Moving around markdown headers
map("n", "<leader>j", [[/^##\+ .*<CR>]], "Go to previous markdown header")
map("n", "<leader>k", [[?^##\+ .*<CR>]], "Go to next markdown header")

-- Toggle between markview hybrid and normal mode (whether or not You want to see line under cursor being rendered)
map("n", "<leader>mt", ":Markview hybridToggle<CR>", "[M]arkview [T]oggle Hybrid Mode")
-- LazyGit - declared in lazygit.lua -  <leader>lg - Opens Lazygit
-- CodeSnap - declared in codesnap.lua -  <leader>cc - Takes beautiful snapshot of code and saves in clipboard

-- Overseer
map("n", "<leader>ot", ":OverseerToggle<CR>", "[O]verseer [T]oggle")
map("n", "<leader>or", ":OverseerRun<CR>", "[O]verseer [R]un")
-- Jupyter Notebook
local runner = require("quarto.runner")
vim.keymap.set("n", "<localleader>rc", runner.run_cell, { desc = "run cell", silent = true })
vim.keymap.set("n", "<localleader>ra", runner.run_above, { desc = "run cell and above", silent = true })
vim.keymap.set("n", "<localleader>rA", runner.run_all, { desc = "run all cells", silent = true })
vim.keymap.set("n", "<localleader>rl", runner.run_line, { desc = "run line", silent = true })
vim.keymap.set("v", "<localleader>r", runner.run_range, { desc = "run visual range", silent = true })
vim.keymap.set(
	"n",
	"<localleader>eo",
	":noautocmd MoltenEnterOutput<CR>",
	{ silent = true, desc = "Show/enter output", buffer = true }
)
vim.keymap.set("n", "<localleader>RA", function()
	runner.run_all(true)
end, { desc = "run all cells of all languages", silent = true })

local default_notebook = [[
  {
    "cells": [
     {
      "cell_type": "markdown",
      "metadata": {},
      "source": [
        ""
      ]
     }
    ],
    "metadata": {
     "kernelspec": {
      "display_name": "Python 3",
      "language": "python",
      "name": "python3"
     },
     "language_info": {
      "codemirror_mode": {
        "name": "ipython"
      },
      "file_extension": ".py",
      "mimetype": "text/x-python",
      "name": "python",
      "nbconvert_exporter": "python",
      "pygments_lexer": "ipython3"
     }
    },
    "nbformat": 4,
    "nbformat_minor": 5
  }
]]

local function new_notebook(filename)
	local path = filename .. ".ipynb"
	local file = io.open(path, "w")
	if file then
		file:write(default_notebook)
		file:close()
		vim.cmd("edit " .. path)
	else
		print("Error: Could not open new notebook file for writing.")
	end
end

vim.api.nvim_create_user_command("NewNotebook", function(opts)
	new_notebook(opts.args)
end, {
	nargs = 1,
	complete = "file",
})

local function create_obsidian_trade_note()
	local template_dir = vim.fn.expand(setup.obsidian_dirs.templates)
	local vault_path = vim.fn.expand(setup.obsidian_dirs.generalpath)
	local trade_folder_name = "8 - Trading" -- Potwierdzona nazwa folderu

	-- Get current date and time
	local date = os.date("%Y-%m-%d")
	local time = os.date("%H:%M")
	local id_date = os.date("%d-%m-%Y") -- Data w formacie DD-MM-YYYY dla ID

	-- Build target directory path
	local target_dir = vault_path .. "/" .. trade_folder_name .. "/" .. date

	-- Create directory if it doesn't exist
	if vim.fn.isdirectory(target_dir) == 0 then
		vim.fn.mkdir(target_dir, "p")
		vim.notify("Created directory: " .. target_dir)
	end

	-- Build new file path
	local new_file_name = "trade-" .. os.date("%H:%M") .. ".md"
	local new_file_path = target_dir .. "/" .. new_file_name

	local template_file = template_dir .. "/trading-template.md"
	local template_content = ""
	local file = io.open(template_file, "r")
	if file then
		template_content = file:read("*a")
		file:close()
	else
		vim.notify("Template file not found: " .. template_file, vim.log.levels.WARN)
	end

	-- Replace {{id}} with current date (DD-MM-YYYY)
	template_content = template_content:gsub("{{id}}", "trade-" .. time .. "_" .. id_date)

	-- Write template content to the new file
	local new_file = io.open(new_file_path, "w")
	if new_file then
		new_file:write(template_content)
		new_file:close()
		vim.notify("Created new trade note: " .. new_file_path)
		vim.cmd("edit " .. vim.fn.fnameescape(new_file_path))
	else
		vim.notify("Error creating new trade note: " .. new_file_path, vim.log.levels.ERROR)
	end
end

vim.api.nvim_create_user_command("ObsidianTrade", create_obsidian_trade_note, {
	desc = "Create a new Obsidian trade note with template",
})

local function create_obsidian_work_note()
	local template_dir = vim.fn.expand(setup.obsidian_dirs.templates)
	local vault_path = vim.fn.expand(setup.obsidian_dirs.generalpath)
	local work_folder_name = "work" -- Nazwa folderu 'work'

	-- Get current date for file name
	local date = os.date("%Y-%m-%d")

	-- Build target directory path
	local target_dir = vault_path .. "/" .. work_folder_name

	-- Build target file path (date as file name with prefix)
	local new_file_name = "work-" .. date .. ".md"
	local new_file_path = target_dir .. "/" .. new_file_name

	-- Check if directory exists and create if not
	if vim.fn.isdirectory(target_dir) == 0 then
		vim.fn.mkdir(target_dir, "p")
		vim.notify("Created directory: " .. target_dir)
	end

	-- *** Now, check if the file already exists ***
	if vim.fn.filereadable(new_file_path) == 1 then
		-- If file exists, just open it
		vim.notify("File already exists. Opening: " .. new_file_path)
		vim.cmd("edit " .. vim.fn.fnameescape(new_file_path))
	else
		-- If file does not exist, create it
		local template_file = template_dir .. "/work-template.md" -- Szablon work-template.md
		local template_content = ""
		local file = io.open(template_file, "r")
		if file then
			template_content = file:read("*a")
			file:close()
			vim.notify("Using template: " .. template_file)
		else
			vim.notify("Template file not found: " .. template_file .. ". Creating empty file.", vim.log.levels.WARN)
			-- Jeśli szablon nie istnieje, utwórz pusty plik
			template_content = ""
		end

		-- Write template content to the new file
		local new_file = io.open(new_file_path, "w")
		if new_file then
			new_file:write(template_content)
			new_file:close()
			vim.notify("Created new work note: " .. new_file_path)
			vim.cmd("edit " .. vim.fn.fnameescape(new_file_path))
		else
			vim.notify("Error creating new work note: " .. new_file_path, vim.log.levels.ERROR)
		end
	end
end

vim.api.nvim_create_user_command("ObsidianWork", create_obsidian_work_note, {
	desc = "Create or open a new Obsidian work note with date as title and template",
})
