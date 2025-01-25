-- This file is custom for each user. Define Your paths necessary for this config to run here.
-- They are imported at the top of init.lua file and used across it
local setup = {
	priority = 2000,
	colorscheme = "kanagawa",
	search_dirs = {
		"~/dev/projects",
	},
	obsidian_dirs = {
		templates = "~/vaults/PrivateV/5 - Templates/",
		dailynotes = "./daily",
		attachments = "assets/",
		generalpath = "~/vaults/PrivateV/",
	},
	chat_dir = "~/vaults/PrivateV/9 - chats/",
}

return setup
