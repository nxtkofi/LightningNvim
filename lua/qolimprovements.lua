---------------> Quality of life improvements <------------------
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
--Lightning-like yanking highlight
vim.api.nvim_set_hl(0, "Visual", { bg = "#475569" })
vim.api.nvim_set_hl(0, "YankHighlight", { bg = "#00274D", fg = "#ADD8E6", bold = true })
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank({ higroup = "YankHighlight", timeout = 150 })
	end,
})
----------------- Quality of life improvements ----------------
