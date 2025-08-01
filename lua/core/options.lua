-- Set <space> as the leader key
vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.g.python3_host_prog = vim.fn.expand("~/.virtualenvs/neovim/bin/python3") -- We're setting virtual environment for jupyter notebook (molten-nvim)

vim.filetype.add({
	extension = {
		ipynb = "python",
	},
})

vim.g.python3_host_prog = vim.fn.expand("~/.virtualenvs/neovim/bin/python3")

-- Set markdown folding to 1
vim.opt.foldenable = true
vim.opt.foldlevelstart = 99
vim.g.markdown_folding = 1

-- Set to true if you have a Nerd Font installed and selected in the terminal
vim.g.have_nerd_font = true
-- See `:help vim.opt`
-- For more options, you can see `:help option-list`

-- Make line numbers default
vim.opt.conceallevel = 1
vim.opt.number = true

-- Relative line numbers
vim.opt.relativenumber = true

-- Enable mouse mode
vim.opt.mouse = "a"

-- Don't show the mode, it's already in the status line
vim.opt.showmode = false

-- Sync clipboard between OS and Neovim.
--  Schedule the setting after `UiEnter` because it can increase startup-time.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.schedule(function()
	vim.opt.clipboard = "unnamedplus"
end)

-- Enable break indent
vim.opt.breakindent = true

-- Save undo history
vim.opt.undofile = true

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Keep signcolumn on by default
vim.opt.signcolumn = "yes"

-- Decrease update time
vim.opt.updatetime = 250

-- Decrease mapped sequence wait time
vim.opt.timeoutlen = 300

-- Configure how new splits should be opened
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Sets how neovim will display certain whitespace characters in the editor.
-- vim.opt.list = true
-- vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- Preview substitutions live, as you type!
vim.opt.inccommand = "split"

-- Show which line your cursor is on
-- vim.opt.cursorline = false

-- Minimal number of screen lines to keep above and below the cursor.
vim.opt.scrolloff = 10
vim.opt.sidescrolloff = 24

-- Remove the ~ tilde signs at the end of the buffer
vim.opt.fillchars = { eob = " " }

-- conditionally render colorschemes.
if vim.g.setup.colorscheme == "miss-dracula" then
	require("colorschemes.miss-dracula").setup()
end

vim.api.nvim_set_hl(0, "Visual", { bg = "#475569" })
vim.api.nvim_set_hl(0, "YankHighlight", { bg = "#00274D", fg = "#ADD8E6", bold = true })
-- open init.lua on :config

local function open_config()
	local config_path = vim.fn.stdpath("config") .. "/init.lua"
	vim.cmd("edit " .. config_path)
end

vim.api.nvim_create_user_command("Config", open_config, {
	desc = "Opens the Neovim configuration file (init.lua)",
})
