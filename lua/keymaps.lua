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
map("n", "[d", vim.diagnostic.goto_prev, "Go to prev [D]iagnostic message")
map("n", "]d", vim.diagnostic.goto_next, "Go to next [D]iagnostic message")
map("n", "<leader>q", vim.diagnostic.setloclist, "Open diagnostic [Q]uickfix list")

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
			vim.fn.jobstart({ "firefox", url }, { detach = true })
			return
		end
	end

	-- Wyszukaj URL w nawiasach `()`
	for url in line:gmatch("%b()") do
		local clean_url = url:sub(2, -2) -- Usuń nawiasy
		if clean_url:match("^https?://") or clean_url:match("^http://") then
			vim.fn.jobstart({ "firefox", clean_url }, { detach = true })
			return
		end
	end

	-- Wyszukaj surowy URL bez Markdown-style linków
	for url in line:gmatch("https?://[%w._~:/?#@!$&'()*+,;=-]+") do
		local start_pos, end_pos = line:find(url, 1, true)
		if start_pos and end_pos and is_cursor_within_range(start_pos, end_pos) then
			vim.fn.jobstart({ "firefox", url }, { detach = true })
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

-- UndoTree and NeoTree
map("n", "<leader>u", ":UndotreeToggle<CR>", "Toggle UndoTree")
map("n", "<leader>b", ":Neotree toggle<CR>", "Toggle NeoTree", { noremap = true, silent = true })

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

-- Quickfix navigation
map("n", "<M-j>", ":cnext<CR>", "Next Quickfix")
map("n", "<M-k>", ":cprev<CR>", "Previous Quickfix")

-- Transparecy toggle
map("n", "<leader>tc", ":TransparentToggle<CR>", "Toggle transparency", { noremap = true, silent = true })

-- Moving around markdown headers
map("n", "<leader>j", [[/^##\+ .*<CR>]], "Go to previous markdown header")
map("n", "<leader>k", [[?^##\+ .*<CR>]], "Go to next markdown header")

-- Toggle between markview hybrid and normal mode (whether or not You want to see line under cursor being rendered)
map("n", "<leader>mt", ":Markview hybridToggle<CR>", "[M]arkview [T]oggle Hybrid Mode")
-- LazyGit - declared in lazygit.lua -  <leader>lg - Opens Lazygit
-- CodeSnap - declared in codesnap.lua -  <leader>cc - Takes beautiful snapshot of code and saves in clipboard
