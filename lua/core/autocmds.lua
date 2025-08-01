-- Autocmd for molten
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
	pattern = "*",
	callback = function()
		if vim.bo.filetype == "markdown" and vim.fn.expand("%:e") == "ipynb" then
			vim.notify("ipynb detected")
			vim.keymap.set(
				"n",
				"<localleader>mi",
				":MoltenInit<CR>",
				{ silent = true, desc = "Initialize the plugin", buffer = true }
			)
			vim.keymap.set(
				"n",
				"<localleader>e",
				":MoltenEvaluateOperator<CR>",
				{ silent = true, desc = "Run operator selection", buffer = true }
			)
			vim.keymap.set(
				"n",
				"<localleader>rl",
				":MoltenEvaluateLine<CR>",
				{ silent = true, desc = "Evaluate line", buffer = true }
			)
			vim.keymap.set(
				"n",
				"<localleader>rr",
				":MoltenReevaluateCell<CR>",
				{ silent = true, desc = "Re-evaluate cell", buffer = true }
			)
			vim.keymap.set(
				"v",
				"<localleader>r",
				":<C-u>MoltenEvaluateVisual<CR>gv",
				{ silent = true, desc = "Evaluate visual selection", buffer = true }
			)

			vim.keymap.set("n", "<localleader>ip", function()
				local venv = os.getenv("VIRTUAL_ENV") or os.getenv("CONDA_PREFIX")
				if venv ~= nil then
					venv = string.match(venv, "/.+/(.+)")
					vim.cmd(("MoltenInit %s"):format(venv))
				else
					vim.cmd("MoltenInit python3")
				end
			end, { desc = "Initialize Molten for python3", silent = true, buffer = true })
		end
	end,
})
-- Restore cursor to file position in previous editing session --
vim.api.nvim_create_autocmd("BufReadPost", {
	callback = function(args)
		local mark = vim.api.nvim_buf_get_mark(args.buf, '"')
		local line_count = vim.api.nvim_buf_line_count(args.buf)
		if mark[1] > 0 and mark[1] <= line_count then
			vim.cmd('normal! g`"zz')
		end
	end,
})
-- resize on <C-w>=
vim.api.nvim_create_autocmd("VimResized", {
	command = "wincmd =",
})
-- self explanatory
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank({ higroup = "YankHighlight", timeout = 150 })
	end,
})
require("utils.autosave").setup()
