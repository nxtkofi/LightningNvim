local setup = {
	priority = 3000,
	transparency = false,
	colorscheme = "oldworld",
	search_dirs = {
		-- Point to your projects folder
		-- Allows You to navigte through projects with <leader>sp
		"~/dev/projects",
	},
	-- Define Your paths here
	-- It's important to keep the formatting as it is.
	-- Obsidian.nvim has a very specific directory pointers so be sure to 'mimic' below configuration.
	-- Make sure the formatting is right!
	-- The following configuration assumes that You have somewhat similar path setup in Your zettelkasten:
	-- ~/path/to/vault/
	--	templates/
	--	daily/
	--	myAssets/
	--	botchats/
	--	...any other folders
	-- You can change folder names to Your liking.
	-- Just make sure that You don't change formattings. Leave '~' and './' where they are.
	obsidian_dirs = {
		templates = "templates/", -- point to a templates folder in Your zettelkasten like so: ~/myvaults/mainvault/templates/
		dailynotes = "./daily", -- point to a daily notes folder in Your zettelkasten like so: ./daily/
		attachments = "myAssets/", -- point to an assets folder in Your zettelkasten like so: assets/
		generalpath = "~/path/to/vault/", -- ~/myvaults/mainvault/
		mainnotes = "~/path/to/vault/mainnotes/", -- This direction specifies what is the main folder for Your notes. This information is used in dashboard - to pick a random note from Your main notes.
	},
	chat_dir = "~/path/to/vault/botchats/", -- This folder can be anywhere in the filesystem. I just happen to want to have my LLM chats inside zettelkasten, so I can reference to them anytime I want.
}

return setup
