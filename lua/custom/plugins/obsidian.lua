return {
	"epwalsh/obsidian.nvim",
	version = "*", -- recommended, use latest release instead of latest commit
	config = function()
		require("obsidian").setup({
			ft = "markdown",
			-- Optional, alternatively you can customize the frontmatter data.
			---@return table
			note_frontmatter_func = function(note)
				if note.title then
					note:add_alias(note.title)
				end
				local out = { id = note.id, date = os.date("%d %B %Y") }
				-- So here we just make sure those fields are kept in the frontmatter.
				if note.metadata ~= nil and not vim.tbl_isempty(note.metadata) then
					for k, v in pairs(note.metadata) do
						out[k] = v
					end
				end
				return out
			end,
			templates = {
				folder = "~/vaults/PrivateV/5 - Templates/",
			},
			daily_notes = {
				folder = "./daily",
				default_tags = { "daily-notes" },
				template = "daily.md",
			},
			completion = {
				nvim_cmp = true,
				min_chars = 2,
			},
			attachments = {
				img_folder = "assets/",
			},
			dependencies = {
				"nvim-lua/plenary.nvim",
			},
			workspaces = {
				{
					name = "personal",
					path = "~/vaults/PrivateV/",
				},
			},
		})
	end,
}
