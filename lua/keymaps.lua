local map = function(mode, keys, func, desc, opts)
	opts = opts or {}
	opts.desc = desc
	vim.keymap.set(mode, keys, func, opts)
end

local builtin = require("telescope.builtin")

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
map("n", "<C-h>", "<C-w><C-h>", "Move focus to the left window")
map("n", "<C-l>", "<C-w><C-l>", "Move focus to the right window")
map("n", "<C-j>", "<C-w><C-j>", "Move focus to the lower window")
map("n", "<C-k>", "<C-w><C-k>", "Move focus to the upper window")

-- Arrow keys hint
map("n", "<left>", '<cmd>echo "Use h to move!!"<CR>', "Hint: Use h")
map("n", "<right>", '<cmd>echo "Use l to move!!"<CR>', "Hint: Use l")
map("n", "<up>", '<cmd>echo "Use k to move!!"<CR>', "Hint: Use k")
map("n", "<down>", '<cmd>echo "Use j to move!!"<CR>', "Hint: Use j")

-- Firefox URL opener
map("n", "<C-CR>", function()
	local url = vim.fn.expand("<cWORD>")
	if url:match("^https?://") then
		vim.fn.jobstart({ "firefox", url }, { detach = true })
	else
		print("No url detected.")
	end
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
