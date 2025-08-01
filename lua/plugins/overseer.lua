return {
	"stevearc/overseer.nvim",
	cmd = { "OverseerRun", "OverseerOpen", "OverseerToggle" },
	config = function()
		local overseer = require("overseer")
		overseer.setup({})
		overseer.register_template({
			name = "cyfrowydochod: Rest API",
			builder = function()
				return {
					label = "Run BE",
					cmd = { "mvn", "spring-boot:run" },
					cwd = "server",
					components = { "default" },
				}
			end,
		})
		overseer.register_template({
			name = "cyfrowydochod: AI microservice",
			builder = function()
				return {
					label = "Run AIm",
					cmd = { "mvn", "spring-boot:run" },
					cwd = "aiservice",
					components = { "default" },
				}
			end,
		})
		overseer.register_template({
			name = "cyfrowydochod: Frontend Dev Server",
			builder = function()
				return {
					label = "Run FE",
					cmd = { "npm", "run", "dev" },
					cwd = "client",
					components = { "default" },
				}
			end,
		})
		overseer.register_template({
			name = "cyfrowydochod: Full Stack",
			builder = function()
				return {
					name = "WebDevelopment",
					strategy = {
						"orchestrator",
						tasks = {
							{
								{ "cyfrowydochod: AI microservice" },
								{ "cyfrowydochod: Rest API" },
								{ "cyfrowydochod: Frontend Dev Server" },
							},
						},
					},
					components = { "default" },
				}
			end,
		})
		-- r016/openSPACE
		overseer.register_template({

			name = "openSPACE:Docker",
			builder = function()
				return {
					label = "Run docker",
					cmd = { "docker", "compose", "up", "-d" },
					cwd = "src/database",
					components = { "default" },
				}
			end,
		})
		overseer.register_template({
			name = "openSPACE:API",
			builder = function()
				return {
					label = "Run REST Api",
					cmd = { "dotnet", "run", "--launch-profile", "https" },
					cwd = "src/openSPACE.API/src/openSPACE.API",
					components = { "default" },
				}
			end,
		})
		overseer.register_template({
			name = "openSPACE:Frontend",
			builder = function()
				return {
					label = "Run nuxt front-end",
					cmd = { "npm", "run", "dev" },
					cwd = "src/openSPACE.ClientApp",
					components = { "default" },
				}
			end,
		})
		overseer.register_template({
			name = "openSPACE: Start Full Stack",
			builder = function()
				return {
					name = "WebDevelopment",
					strategy = {
						"orchestrator",
						tasks = {
							{ { "openSPACE:Docker" }, { "openSPACE:API" }, { "openSPACE:Frontend" } },
						},
					},
					components = { "default" },
				}
			end,
		})

		overseer.register_template({
			name = "florart: Strapi API",
			builder = function()
				return {
					label = "Run Strapi",
					cmd = { "npm", "run", "dev" },
					cwd = "server/strapi",
					components = { "default" },
				}
			end,
		})
		overseer.register_template({
			name = "florart: Front-end",
			builder = function()
				return {
					label = "Run front",
					cmd = { "npm", "run", "dev" },
					cwd = "client",
					components = { "default" },
				}
			end,
		})
		overseer.register_template({
			name = "florart: Full Stack",
			builder = function()
				return {
					name = "WebDevelopment",
					strategy = {
						"orchestrator",
						tasks = {
							{ { "florart: Strapi API" }, { "florart: Front-end" } },
						},
					},
					components = { "default" },
				}
			end,
		})
	end,
}
